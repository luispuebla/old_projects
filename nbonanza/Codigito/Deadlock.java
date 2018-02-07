public class Deadlock
{
	public static void main( String[] args )
	{
		final Object resource1 = new Object();
		final Object resource2 = new Object();

		Thread t1 = new Thread(
				new Runnable(){
					public void run(){
						try{	  
							Thread.sleep( (long)Math.ceil(Math.random()*10000) );	  
							synchronized(resource1){
								System.out.println(">> Thread 1 lock resource 1");	  
									Thread.sleep( (long)Math.ceil(Math.random()*10000) );	  
								synchronized(resource2){
									System.out.println(">> Thread 1 lock resource 2");	  
									System.out.println("-- Area critica thread 1");	  
								}// fin sybchronized 2
								System.out.println("<< Thread 1 release resource 2");	  
							}// fin synchronized 1
							System.out.println("<< Thread 1 release resource 1");	  
						}
						catch( InterruptedException e ){}
					}// fin metodo run
				}// fin clase anonima
		);

		Thread t2 = new Thread(
				new Runnable(){
					public void run(){
						try{
							Thread.sleep( (long)Math.ceil(Math.random()*10000) );	  
							synchronized(resource1){
								System.out.println(">> Thread 2 lock resource 1");	  
								Thread.sleep( (long)Math.ceil(Math.random()*10000) );	  
								synchronized(resource2){
									System.out.println(">> Thread 2 lock resource 2");	  
									System.out.println("-- Area critica thread 2");	  
								}// fin sybchronized 2
								System.out.println("<< Thread 2 release resource 2");	  
							}// fin synchronized 1
							System.out.println("<< Thread 2 release resource 1");	  
						}
						catch( InterruptedException e ){}
					}// fin metodo run
				}// fin clase anonima
		);

		t1.start();
		t2.start();

	}
}
