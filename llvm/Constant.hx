package llvm;

import llvm.Type.TypeUtil;

class Constant {
	public final type : Type;
	public final value : String;
	public function new(type:Type, value:String) {
		this.type = type;
		this.value = value;
	}

	public static function stringConstant(value:String, ?nullTerminated:Bool=false):Constant {
		final length = value.length;
		value = value.split('').map(function(e) {
			if(e.charCodeAt(0) < 32 || e.charCodeAt(0) > 126) {
				return '\\${StringTools.hex(e.charCodeAt(0), 2)}';
			} else {
				return e;
			}
		}).join('');
		if(nullTerminated) {
			value += "\\00";
			return new Constant(Type.TArray(length+1, TInt(8)), 'c"${value}"');
		}
		return new Constant(Type.TArray(length, TInt(8)), 'c"${value}"');
	}

	public function toString() {
		return '${value}';
	}

	public function toTypedString() {
		switch type {
			case TVoid: return 'void';
			case TTypedPtr(t): return '${TypeUtil.toString(t)}* ${value}';
			case TPtr: return 'ptr ${value}';
			default: return '${TypeUtil.toString(type)} ${value}';
		}
	}
}