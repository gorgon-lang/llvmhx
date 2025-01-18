package llvm;

import llvm.Operand.OperandUtil;
import llvm.Type.TypeUtil;

class Builder {
	public final context : Context;
	public final buffer : StringBuf;

	public function new(context:Context) {
		this.context = context;
		this.buffer = new StringBuf();
	}

	public inline function renderModuleDef(name:String) : Void {
		if( this.context.hasComments ) {
			this.buffer.add('; ModuleID = "${name}"\n');
		}
		this.buffer.add('source_filename = "${name}"\n');
	}

	public inline function renderFunction(def:Function) : Void {
		this.buffer.add("define ");
		this.buffer.add('${TypeUtil.toString(def.returnType)}');
		this.buffer.add(' @${def.name}(');
		for(i in 0...def.params.length) {
			if(i > 0) {
				this.buffer.add(', ');
			}
			this.buffer.add('${def.params[i].toTypedString()}');
		}
		this.buffer.add(') {\n');

		for(bodyDef in def.body) {
			switch bodyDef {
				case Label(name, instructions):
					this.buffer.add('${name}:\n');
					for(instruction in instructions) {
						this.renderInstruction(instruction);
					}
				case Instruction(instruction):
					this.renderInstruction(instruction);
			}
		}
		this.buffer.add('}\n');
	}

	private inline function renderRetInstruction(operand:Operand) : Void {
		switch operand {
			case Constant(value):
				this.buffer.add('ret ${value.toTypedString()}\n');
			case Identifier(value):
				this.buffer.add('ret ${value.toTypedString()}\n');
		}
	}

	private inline function renderBrInstruction(cond:Operand, ifTrue:Identifier, ifFalse:Identifier, ?dest:Identifier) : Void {
		if(dest != null) {
			this.buffer.add('br label ${dest.toString()}\n');
			return;
		}
		switch cond {
			case Constant(value):
				this.buffer.add('br i1 ${value}, label %${ifTrue}, label %${ifFalse}\n');
			case Identifier(value):
				this.buffer.add('br i1 ${value.toString()}, label ${ifTrue.toString()}, label %${ifFalse.toString()}\n');
		}
	}

	private inline function renderAddInstruction(res:Identifier, type:Type, lhs:Operand, rhs:Operand, ?signWrap:Bool=false, ?unsignWrap:Bool=false) : Void {
		if(unsignWrap == null) {
			unsignWrap = false;
		}
		if(signWrap == null) {
			signWrap = false;
		}
		this.buffer.add('${res.toString()} = add ${TypeUtil.toString(type)} ${signWrap ? 'nsw ' : ''}${unsignWrap ? 'nuw ' : ''}${OperandUtil.toString(lhs)}, ${OperandUtil.toString(rhs)}\n');
	}

	private inline function renderSubInstruction(res:Identifier, type:Type, lhs:Operand, rhs:Operand, ?signWrap:Bool=false, ?unsignWrap:Bool=false) : Void {
		if(unsignWrap == null) {
			unsignWrap = false;
		}
		if(signWrap == null) {
			signWrap = false;
		}
		this.buffer.add('${res.toString()} = sub ${TypeUtil.toString(type)} ${signWrap ? 'nsw ' : ''}${unsignWrap ? 'nuw ' : ''}${OperandUtil.toString(lhs)}, ${OperandUtil.toString(rhs)}\n');
	}

	private inline function renderFaddInstruction(dest:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?fmflags:FastMathFlag) : Void {
		this.buffer.add('${dest.toString()} = fadd ${TypeUtil.toString(resultType)} ${OperandUtil.toString(lhs)}, ${OperandUtil.toString(rhs)}\n');
	}

	private inline function renderFsubInstructon(dest:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?fmflags:FastMathFlag) : Void {
		this.buffer.add('${dest.toString()} = fsub ${TypeUtil.toString(resultType)} ${OperandUtil.toString(lhs)}, ${OperandUtil.toString(rhs)}\n');
	}

	private inline function renderInstruction(instruction:Instruction) {
		switch instruction {
			case Ret(operand):
				this.renderRetInstruction(operand);
			case Br(dest, cond, iftrue, iffalse):
				this.renderBrInstruction(cond, iftrue, iffalse, dest);
			case Add(res, resultType, lhs, rhs, nuw, nsw):
				this.renderAddInstruction(res, resultType, lhs, rhs, nuw, nsw);
			case Sub(res, resultType, lhs, rhs, nuw, nsw):
				this.renderSubInstruction(res, resultType, lhs, rhs, nuw, nsw);
			case Fadd(res, resultType, lhs, rhs, fmflags):
				this.renderFaddInstruction(res, resultType, lhs, rhs, fmflags);
			case FSub(res, resultType, lhs, rhs, fmflags):
				this.renderFsubInstructon(res, resultType, lhs, rhs, fmflags);
		}
	}

	public inline function getIR() : String {
		return this.buffer.toString();
	}
}