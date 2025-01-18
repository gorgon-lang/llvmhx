package llvm;

import llvm.Type.TypeUtil;

class Identifier {
	public final type : Type;
	public final name : String;
	public function new(type:Type, name:String) {
		this.type = type;
		this.name = name;
	}

	public function toString() {
		return '%${name}';
	}

	public function toTypedString() {
		return '${TypeUtil.toString(type)} %${name}';
	}
}