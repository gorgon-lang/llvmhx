package llvm;

enum Visibility {
	Default;
	Hidden;
	Protected;
}

class VisibilityUtil {
	public inline function toString(v:Visibility) {
		switch v {
			case Default: return "default";
			case Hidden: return "hidden";
			case Protected: return "protected";
		}
	}
}