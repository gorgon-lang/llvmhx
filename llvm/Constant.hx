package llvm;

import llvm.Type.TypeUtil;

class Constant {
	final type : Type;
	final value : String;
	public function new(type:Type, value:String) {
		this.type = type;
		this.value = value;
	}

	public function toString() {
		return '${value}';
	}

	public function toTypedString() {
		if(type == Type.TVoid) {
			return 'void';
		}
		return '${TypeUtil.toString(type)} ${value}';
	}
}