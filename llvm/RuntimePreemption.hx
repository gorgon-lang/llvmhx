package llvm;

enum RuntimePreemption {
	None;
	Local;
	Preemptible;
}

class RuntimePreemptionUtil {
	public static inline function toString(v:RuntimePreemption) {
		switch v {
			case None: return "";
			case Local: return "dso_local";
			case Preemptible: return "dso_preemptible";
		}
	}
}