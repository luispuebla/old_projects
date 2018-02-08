package alphanet.ultra.digibar.bd;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.Vector;

public class ManagerAuxiliar
{
  protected Vector<String> datosMapa;
  
  public Vector<String> comprimeVector(Vector<String> paramVector)
    throws Exception
  {
    Vector localVector1 = new Vector();
    int i = 0;
    if (paramVector.size() == 1) {
      localVector1.addElement("1 - " + ((String)paramVector.elementAt(0)).trim());
    } else {
      for (int j = 0; j < paramVector.size(); j++)
      {
        String str = (String)paramVector.elementAt(j);
        for (int k = 0; k < paramVector.size(); k++) {
          if (str.equalsIgnoreCase((String)paramVector.elementAt(k))) {
            i++;
          }
        }
        localVector1.addElement(i + " - " + str);
        Vector localVector2 = new Vector();
        int m = 1;
        for (int n = 0; n < paramVector.size(); n++) {
          if (((String)paramVector.elementAt(n)).equalsIgnoreCase(str))
          {
            if (m != 0)
            {
              m = 0;
              localVector2.addElement(paramVector.elementAt(n));
            }
          }
          else {
            localVector2.addElement(paramVector.elementAt(n));
          }
        }
        paramVector = localVector2;
        i = 0;
      }
    }
    return localVector1;
  }
  
  public static void main(String[] paramArrayOfString)
    throws Exception
  {
    Vector localVector1 = new Vector();
    /*localVector1.addElement("hola");
    localVector1.addElement("hola");
    localVector1.addElement("hola");
    localVector1.addElement("hola");
    localVector1.addElement("adios");
    localVector1.addElement("hola");
    localVector1.addElement("adios");
    localVector1.addElement("hola");
    localVector1.addElement("hola");
    localVector1.addElement("que hubo");
    localVector1.addElement("cuando");*/
    ManagerAuxiliar localManagerAuxiliar = new ManagerAuxiliar();
    Vector localVector2 = localManagerAuxiliar.comprimeVector(localVector1);
    for (int i = 0; i < localVector2.size(); i++) {
      System.out.println((String)localVector2.elementAt(i));
    }
  }
  
  public String completaString(String paramString)
    throws Exception
  {
    String str = paramString;
    try
    {
      int i = paramString.length();
      i = 6 - i;
      for (int j = 0; j < i; j++) {
        str = "0" + str;
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return str;
  }
  
  public String completaStringTicket(String paramString)
    throws Exception
  {
    String str = paramString;
    try
    {
      int i = paramString.length();
      i = 7 - i;
      for (int j = 0; j < i; j++) {
        str = "0" + str;
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return str;
  }
  
  public String completaStringTipoPLU(String paramString)
    throws Exception
  {
    String str = paramString;
    try
    {
      int i = paramString.length();
      i = 2 - i;
      for (int j = 0; j < i; j++) {
        str = "0" + str;
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return str;
  }
  
  public int cambiaAInt(String paramString)
    throws Exception
  {
    int i;
    try
    {
      i = Integer.parseInt(paramString);
    }
    catch (NumberFormatException localNumberFormatException)
    {
      i = 0;
    }
    return i;
  }
  
  public String remueveComas(String paramString)
  {
    StringBuffer localStringBuffer = new StringBuffer(paramString);
    while (localStringBuffer.indexOf(",") != -1) {
      localStringBuffer.deleteCharAt(localStringBuffer.indexOf(","));
    }
    return paramString = new String(localStringBuffer.toString());
  }
  
  public double cambiaADouble(String paramString)
    throws Exception
  {
    if (paramString == null) {
      paramString = "";
    }
    double d;
    try
    {
      Double localDouble = Double.valueOf(paramString);
      d = localDouble.doubleValue();
    }
    catch (NumberFormatException localNumberFormatException)
    {
      d = 0.0D;
    }
    return d;
  }
  
  public String acortaLongitud(String paramString)
  {
    StringBuffer localStringBuffer = new StringBuffer(paramString);
    if (localStringBuffer.indexOf(".") != -1)
    {
      String str1 = localStringBuffer.substring(localStringBuffer.indexOf("."));
      
      String str2 = localStringBuffer.substring(0, localStringBuffer.indexOf("."));
      localStringBuffer.delete(0, localStringBuffer.length());
      if (str1.length() > 3) {
        str1 = str1.substring(0, 3);
      }
      if (str1.length() <= 2) {
        str1 = str1 + "0";
      }
      localStringBuffer.append(str2);
      localStringBuffer.append(str1);
    }
    return localStringBuffer.toString();
  }
  
  public String formatoDinero(String paramString)
  {
    StringBuffer localStringBuffer = new StringBuffer(dameEnteros(paramString));
    String str = dameDecimales(paramString);
    if (localStringBuffer.length() == 8)
    {
      localStringBuffer.insert(2, ',');
      localStringBuffer.insert(6, ',');
    }
    else if (localStringBuffer.length() == 7)
    {
      localStringBuffer.insert(1, ',');
      localStringBuffer.insert(5, ',');
    }
    else if (localStringBuffer.length() == 4)
    {
      localStringBuffer.insert(1, ',');
    }
    else if (localStringBuffer.length() == 5)
    {
      localStringBuffer.insert(2, ',');
    }
    else if (localStringBuffer.length() == 6)
    {
      localStringBuffer.insert(3, ',');
    }
    return localStringBuffer.toString() + "." + str;
  }
  
  public String dameDecimales(String paramString)
  {
    StringBuffer localStringBuffer = new StringBuffer(paramString);
    int i = 0;
    if (localStringBuffer.indexOf(".") != -1)
    {
      localStringBuffer = localStringBuffer.delete(0, localStringBuffer.indexOf(".") + 1);
      i = 1;
    }
    if (i == 0) {
      localStringBuffer = new StringBuffer("00");
    }
    return localStringBuffer.toString();
  }
  
  public String dameEnteros(String paramString)
  {
    StringBuffer localStringBuffer = new StringBuffer(paramString);
    if (localStringBuffer.indexOf(".") != -1) {
      localStringBuffer = localStringBuffer.delete(localStringBuffer.indexOf("."), localStringBuffer.length());
    }
    return localStringBuffer.toString();
  }
  
  protected String formatoEspaciado(String paramString)
    throws Exception
  {
    int i = paramString.length();
    while (i < 10)
    {
      paramString = "  " + paramString;
      i++;
    }
    StringBuilder localStringBuilder = new StringBuilder(paramString);
    int j = 0;
    while (localStringBuilder.indexOf("1") != -1)
    {
      localStringBuilder.replace(localStringBuilder.indexOf("1"), localStringBuilder.indexOf("1") + 1, "*");
      j++;
    }
    while (localStringBuilder.indexOf("*") != -1) {
      localStringBuilder.replace(localStringBuilder.indexOf("*"), localStringBuilder.indexOf("*") + 1, "1");
    }
    while (j > 0)
    {
      paramString = " " + paramString;
      j--;
    }
    return paramString;
  }
  
  protected String formatoEspaciado2(String paramString)
    throws Exception
  {
    int i = paramString.length();
    while (i < 10)
    {
      paramString = "  " + paramString;
      i++;
    }
    return paramString;
  }
  
  public static String codifica(String paramString)
    throws UnsupportedEncodingException
  {
    String str = URLEncoder.encode(paramString, "UTF-8");
    return str;
  }
  
  public Date cambiaADate(String paramString)
  {
    Date localDate;
    try
    {
      localDate = Date.valueOf(new String(paramString));
    }
    catch (IllegalArgumentException localIllegalArgumentException)
    {
      localDate = Date.valueOf(new String("9999-10-10"));
    }
    return localDate;
  }
}
