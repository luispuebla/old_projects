import java.io.*;

public class Filter
{
	File directorio;

	public Filter( String dir )
	{
		this.directorio = new File( dir );
		if( !directorio.exists() )
			throw new IllegalArgumentException("No existe");
		if( !directorio.isDirectory() )
			throw new IllegalArgumentException("No es directorio");
		if( !directorio.canRead() )
			throw new IllegalArgumentException("No hay permisos");
	}

	public void lista( String sufijo )
	{
		final String s = sufijo;
		class Filtro implements FilenameFilter
		{
			public boolean accept( File d, String n )
			{ return n.endsWith(s); }
		}
		Filtro f = new Filtro();
		String[] lista = directorio.list( f );
		for( int i = 0; i < lista.length; i++ )
			System.out.println( lista[i] );
		System.out.println("================================");

		lista = directorio.list( new FilenameFilter(){
			public boolean accept( File d, String n )
			{ return n.endsWith(s); }
		});
		for( int i = 0; i < lista.length; i++ )
			System.out.println( lista[i] );
	}

	public static void main( String[] args )
	{
		for( int i = 0; i < args.length; i++ )
			System.out.println( args[i] );
		System.out.println("================================");

		try{
			Filter f = new Filter( args[0] );
			f.lista( args[1] );
		}
		catch( Exception e )
		{ e.printStackTrace(); }
	}

}
