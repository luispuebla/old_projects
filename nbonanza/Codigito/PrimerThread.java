import java.util.Date;

public class PrimerThread extends Thread
{
	Date fecha;
	int limite;
	int id;
	static int tid = 0;
		  
	public PrimerThread( int limite )
	{
		fecha = new Date();
		this.limite = limite;
		this.id = tid++;
	}

	public void run()
	{
		while( limite-- > 0 )
		{
			try{	  
				long dormir = (long) Math.random()*2000;	  
				Thread.sleep( dormir );	  
			}
			catch( InterruptedException e ){}
			imprimeFecha();		  
		}
	}

	public void imprimeFecha()
	{ System.out.println( id +" "+ fecha ); }

	public static void main( String[] args )
	{
		Thread[] t = new Thread[10];	  
		for( int i = 0; i < 10; i++ )
			t[i] = new PrimerThread( 20 );
		for( int i = 0; i < 10; i++ )
			t[i].start();	  
	}
}

















