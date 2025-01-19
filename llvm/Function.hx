package llvm;

import llvm.Parameter;
import llvm.Type.TypeUtil;
import llvm.UnnamedAddressSpace;
import llvm.CallingConventions;
import llvm.CallingConventions.CallingConventionTool;
import llvm.DLLStorage;
import llvm.Visibility.VisibilityUtil;
import llvm.FunctionBody;
import llvm.Constant;
import llvm.Identifier;
import llvm.ParameterAttribute;
import llvm.RuntimePreemption;
import llvm.LinkageType;

typedef FunctionDef = {
	final name : String;
	var returnType : Type;
	var arguments : Array<Parameter>;
	var ?body : FunctionBody;
	var ?linkage : LinkageType;
	var ?preemption : RuntimePreemption;
	var ?visibility : Visibility;
	var ?dllStorageClass : DLLStorage;
	var ?callingConv : CallingConventions;
	var ?returnAttributes : Array<ParameterAttribute>;
	var ?unnamedAddr : UnnamedAddressSpace;
	var ?addressSpace : Int;
	var ?section : String;
	var ?partition : String;
	var ?comdat : String;
	var ?alignment : Int;
	var ?gc : String;
	var ?prefix : Constant;
	var ?prologue : Constant;
	var ?personality : Constant;
}

@:forward
abstract Function(FunctionDef) from FunctionDef to FunctionDef {
	public function new(def:FunctionDef) {
		this = def;
	}

	public function getPtr() : String {
		return '@${this.name}';
	}

	public function toString() : String {
		final buffer : StringBuf = new StringBuf();

		if(this.body == null) {
			buffer.add("declare ");
		} else {
			buffer.add("define ");
		}

		if(this.linkage != null) {
			buffer.add('${LinkageTypeUtil.toString(this.linkage)} ');
		}

		if(this.preemption != null) {
			buffer.add('${RuntimePreemptionUtil.toString(this.preemption)} ');
		}

		if(this.visibility != null) {
			buffer.add('${VisibilityUtil.toString(this.visibility)} ');
		}

		if(this.dllStorageClass != null) {
			buffer.add('${DLLStorageUtil.toString(this.dllStorageClass)} ');
		}

		if(this.callingConv != null) {
			buffer.add('${CallingConventionTool.toString(this.callingConv)} ');
		}

		if(this.returnAttributes != null) {
			for(returnAttr in this.returnAttributes) {
				buffer.add('${ParameterAttributeTool.toString(returnAttr)} ');
			}
		}

		buffer.add('${TypeUtil.toString(this.returnType)} ');
		buffer.add('@${this.name}(');

		if(this.arguments.length > 0) {
			if(this.body == null) {
				buffer.add('${this.arguments[0].toUnnamedString()}');
			} else {
				buffer.add('${this.arguments[0].toString()}');
			}
			for(i in 1...this.arguments.length) {
				if(this.body == null) {
					buffer.add('${this.arguments[i].toUnnamedString()}');
				} else {
					buffer.add(', ${this.arguments[i].toString()}');
				}
			}
		}
		buffer.add(')');

		if(this.unnamedAddr != null) {
			buffer.add('${UnnamedAddressSpaceUtil.toString(this.unnamedAddr)} ');
		}

		if(this.addressSpace != null) {
			buffer.add('addrspace(${this.addressSpace}) ');
		}

		if(this.section != null) {
			buffer.add('section "${this.section}" ');
		}

		if(this.partition != null) {
			buffer.add('partition "${this.partition}" ');
		}

		if(this.comdat != null) {
			buffer.add('comdat "${this.comdat}" ');
		}

		if(this.alignment != null) {
			buffer.add('align ${this.alignment} ');
		}

		if(this.gc != null) {
			buffer.add('gc "${this.gc}" ');
		}

		if(this.prefix != null) {
			buffer.add('prefix ${this.prefix.toTypedString()} ');
		}

		if(this.prologue != null) {
			buffer.add('prologue ${this.prologue.toTypedString()} ');
		}

		if(this.personality != null) {
			buffer.add('personality ${this.personality.toTypedString()} ');
		}

		return buffer.toString();
	}
}