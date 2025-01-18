package llvm;

class Module {
	public final context : Context;

	public function new(name:String, context:Context) {
		this.context = context;
	}

	public function addFunction(name:String, type:Type, params:Array<Dynamic>) : Void {
		
	}
}