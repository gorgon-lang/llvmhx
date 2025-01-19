package llvm;

import llvm.Type.TypeUtil;

class Identifier {
	public static final NAMED_VALIDATOR : EReg = ~/[-a-zA-Z$._][-a-zA-Z$._0-9]*/;
	public static final UNNAMED_VALIDATOR : EReg = ~/[-a-zA-Z$._0-9]*/;
	public final type : Type;
	public final name : String;
	public function new(type:Type, name:String) {
		this.type = type;
		if(!UNNAMED_VALIDATOR.match(name)) {
			throw new haxe.Exception('Invalid identifier ${name}');
		}
		this.name = name;
	}

	public function toString() {
		return '%${name}';
	}

	public function toTypedString() {
		if(name == '') {
			return TypeUtil.toString(type);
		}
		return '${TypeUtil.toString(type)} %${name}';
	}
}