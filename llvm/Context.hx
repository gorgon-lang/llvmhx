package llvm;

class Context {
	private var unnamedGlobalLastID : Int = 0;
	private var unnamedIdentifierLastID : Int = 2;

	public function new() {
		
	}

	public function unnamedGlobal(type:Type) : GlobalVar {
		return new GlobalVar({
			name: Std.string(unnamedGlobalLastID++),
			type: type
		});
	}

	public function unnamedId(type:Type) : Identifier {
		return new Identifier(type, Std.string(unnamedIdentifierLastID++));
	}
}