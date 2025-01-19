package llvm;

enum UnnamedAddressSpace {
	Unnamed;
	LocalUnnamed;
}

class UnnamedAddressSpaceUtil {
	public static inline function toString(v:UnnamedAddressSpace) {
		switch v {
			case Unnamed: return "unnamed_addr";
			case LocalUnnamed: return "local_unnamed_addr";
		}
	}
}