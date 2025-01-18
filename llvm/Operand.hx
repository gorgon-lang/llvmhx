package llvm;

import llvm.Identifier;
import llvm.Constant;

enum Operand {
	Constant(value:Constant);
	Identifier(value:Identifier);
}

class OperandUtil {
	public static function toString(operand:Operand) : String {
		switch operand {
			case Constant(value):
				return value.toString();
			case Identifier(value):
				return value.toString();
		}
	}

	public static function toTypedString(operand:Operand) : String {
		switch operand {
			case Constant(value):
				return value.toTypedString();
			case Identifier(value):
				return value.toTypedString();
		}
	}
}