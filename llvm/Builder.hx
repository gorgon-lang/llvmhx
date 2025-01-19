package llvm;

import llvm.GlobalVar;
import llvm.FunctionAttribute.FunctionAttributeUtil;
import llvm.ParameterAttribute.ParameterAttributeTool;
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
		this.buffer.add('${def.toString()} {\n');
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

	public inline function renderGlobalVar(def:GlobalVar) : Void {
		this.buffer.add('${def.toString()}\n');
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

	private inline function renderMulInstruction(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?nuw:Bool=false, ?nsw:Bool=false) : Void {
		this.buffer.add('${res.toString()} = mul ${TypeUtil.toString(resultType)} ${nuw ? 'nuw ' : ''}${nsw ? 'nsw ' : ''}${OperandUtil.toString(lhs)}, ${OperandUtil.toString(rhs)}\n');
	}

	private inline function renderFMulInstruction(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?fmflags:FastMathFlag) : Void {
		this.buffer.add('${res.toString()} = fmul ${TypeUtil.toString(resultType)} ${OperandUtil.toString(lhs)}, ${OperandUtil.toString(rhs)}\n');
	}

	private inline function renderUDivInstruction(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?exact:Bool=false) : Void {
		this.buffer.add('${res.toString()} = udiv ${TypeUtil.toString(resultType)} ${OperandUtil.toString(lhs)}, ${OperandUtil.toString(rhs)}\n');
	}

	private inline function renderSDivInstruction(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?exact:Bool=false) : Void {
		this.buffer.add('${res.toString()} = sdiv ${TypeUtil.toString(resultType)} ${OperandUtil.toString(lhs)}, ${OperandUtil.toString(rhs)}\n');
	}

	private inline function renderFDivInstruction(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?fmflags:FastMathFlag) : Void {
		this.buffer.add('${res.toString()} = fdiv ${TypeUtil.toString(resultType)} ${OperandUtil.toString(lhs)}, ${OperandUtil.toString(rhs)}\n');
	}

	private inline function renderURemInstruction(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand) : Void {
		this.buffer.add('${res.toString()} = urem ${TypeUtil.toString(resultType)} ${OperandUtil.toString(lhs)}, ${OperandUtil.toString(rhs)}\n');
	}

	private inline function renderSRemInstruction(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand) : Void {
		this.buffer.add('${res.toString()} = srem ${TypeUtil.toString(resultType)} ${OperandUtil.toString(lhs)}, ${OperandUtil.toString(rhs)}\n');
	}

	private inline function renderFRemInstruction(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?fmflags:FastMathFlag) : Void {
		this.buffer.add('${res.toString()} = frem ${TypeUtil.toString(resultType)} ${OperandUtil.toString(lhs)}, ${OperandUtil.toString(rhs)}\n');
	}

	private inline function renderShlInstruction(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?nuw:Bool=false, ?nsw:Bool=false) : Void {
		this.buffer.add('${res.toString()} = shl ${TypeUtil.toString(resultType)} ${nuw ? 'nuw ' : ''}${nsw ? 'nsw ' : ''}${OperandUtil.toString(lhs)}, ${OperandUtil.toString(rhs)}\n');
	}

	private inline function renderLShrInstruction(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?exact:Bool=false) : Void {
		this.buffer.add('${res.toString()} = lshr ${TypeUtil.toString(resultType)} ${OperandUtil.toString(lhs)}, ${OperandUtil.toString(rhs)}\n');
	}

	private inline function renderAShrInstruction(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?exact:Bool=false) : Void {
		this.buffer.add('${res.toString()} = ashr ${TypeUtil.toString(resultType)} ${OperandUtil.toString(lhs)}, ${OperandUtil.toString(rhs)}\n');
	}

	private inline function renderAndInstruction(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand) : Void {
		this.buffer.add('${res.toString()} = and ${TypeUtil.toString(resultType)} ${OperandUtil.toString(lhs)}, ${OperandUtil.toString(rhs)}\n');
	}

	private inline function renderOrInstruction(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand) : Void {
		this.buffer.add('${res.toString()} = or ${TypeUtil.toString(resultType)} ${OperandUtil.toString(lhs)}, ${OperandUtil.toString(rhs)}\n');
	}

	private inline function renderXorInstruction(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand) : Void {
		this.buffer.add('${res.toString()} = xor ${TypeUtil.toString(resultType)} ${OperandUtil.toString(lhs)}, ${OperandUtil.toString(rhs)}\n');
	}

	private inline function renderCallInstruction(res:Identifier, resultType:Type, args:Array<Identifier>, ?tail:CallTail, ?fmflags:FastMathFlag, ?retAttr:Array<ParameterAttribute>, ?addrspace:Int, ?fnAttrs:Array<FunctionAttribute>) : Void {
		this.buffer.add('${res.toString()} = call ${TypeUtil.toString(resultType)} ');
		if(fnAttrs != null) {
			this.buffer.add('[');
			for(i in 0...fnAttrs.length) {
				if(i > 0) {
					this.buffer.add(', ');
				}
				this.buffer.add('${FunctionAttributeUtil.toString(fnAttrs[i])}');
			}
			this.buffer.add('] ');
		}
		if(addrspace != null) {
			this.buffer.add('addrspace(${addrspace}) ');
		}
		if(fmflags != null) {
			this.buffer.add('fastmath ');
		}
		if(retAttr != null) {
			this.buffer.add('[');
			for(i in 0...retAttr.length) {
				if(i > 0) {
					this.buffer.add(', ');
				}
				this.buffer.add('${ParameterAttributeTool.toString(retAttr[i])}');
			}
			this.buffer.add('] ');
		}
		this.buffer.add('${args[0].toString()}');
		for(i in 1...args.length) {
			this.buffer.add(', ${args[i].toString()}');
		}
		this.buffer.add('\n');
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
			case Mul(res, resultType, lhs, rhs, nuw, nsw):
				this.renderMulInstruction(res, resultType, lhs, rhs, nuw, nsw);
			case FMul(res, resultType, lhs, rhs, fmflags):
				this.renderFMulInstruction(res, resultType, lhs, rhs, fmflags);
			case UDiv(res, resultType, lhs, rhs, exact):
				this.renderUDivInstruction(res, resultType, lhs, rhs, exact);
			case SDiv(res, resultType, lhs, rhs, exact):
				this.renderSDivInstruction(res, resultType, lhs, rhs, exact);
			case FDiv(res, resultType, lhs, rhs, fmflags):
				this.renderFDivInstruction(res, resultType, lhs, rhs, fmflags);
			case URem(res, resultType, lhs, rhs):
				this.renderURemInstruction(res, resultType, lhs, rhs);
			case SRem(res, resultType, lhs, rhs):
				this.renderSRemInstruction(res, resultType, lhs, rhs);
			case FRem(res, resultType, lhs, rhs, fmflags):
				this.renderFRemInstruction(res, resultType, lhs, rhs, fmflags);
			case Shl(res, resultType, lhs, rhs, nuw, nsw):
				this.renderShlInstruction(res, resultType, lhs, rhs, nuw, nsw);
			case LShr(res, resultType, lhs, rhs, exact):
				this.renderLShrInstruction(res, resultType, lhs, rhs, exact);
			case AShr(res, resultType, lhs, rhs, exact):
				this.renderAShrInstruction(res, resultType, lhs, rhs, exact);
			case And(res, resultType, lhs, rhs):	
				this.renderAndInstruction(res, resultType, lhs, rhs);
			case Or(res, resultType, lhs, rhs):
				this.renderOrInstruction(res, resultType, lhs, rhs);
			case Xor(res, resultType, lhs, rhs):
				this.renderXorInstruction(res, resultType, lhs, rhs);
			case Call(res, resultType, args, t, fmflags, retAttr, addrspace, fnAttrs):
				this.renderCallInstruction(res, resultType, args, t, fmflags, retAttr, addrspace, fnAttrs);
		}
	}

	public inline function getIR() : String {
		return this.buffer.toString();
	}
}