package llvm;

enum LinkageType {
	Private;
	Internal;
	AvailableExternally;
	LinkOnce;
	Weak;
	Common;
	Appending;
	ExternWeak;
	LinkOnceODR;
	WeakODR;
	External;
}

class LinkageTypeUtil {
	public static inline function toString(v:LinkageType) {
		switch v {
			case Private: return "private";
			case Internal: return "internal";
			case AvailableExternally: return "available_externally";
			case LinkOnce: return "linkonce";
			case Weak: return "weak";
			case Common: return "common";
			case Appending: return "appending";
			case ExternWeak: return "extern_weak";
			case LinkOnceODR: return "linkonce_odr";
			case WeakODR: return "weak_odr";
			case External: return "external";
		}
	}
}