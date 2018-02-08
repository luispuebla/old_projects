package alphanet.ultra.digibar.bd;

import java.util.Calendar;

public class TimeStamp
{
  private Calendar tiempoSistema;
  public String time;
  public String date;
  public String datetime;
  public String nombreGrafico;
  public int toDay;
  
  public TimeStamp()
  {
    this.tiempoSistema = Calendar.getInstance();
    obtenDatos();
  }
  
  public void obtenDatos()
  {
    StringBuffer localStringBuffer1 = new StringBuffer();
    StringBuffer localStringBuffer2 = new StringBuffer();
    StringBuffer localStringBuffer3 = new StringBuffer();
    String str1 = new String(this.tiempoSistema.get(1) + "");
    int i = this.tiempoSistema.get(2) + 1;
    String str2 = new String(checkSize(i));
    int j = this.tiempoSistema.get(5);
    this.toDay = j;
    String str3 = new String(checkSize(j));
    int k = this.tiempoSistema.get(11);
    String str4 = new String(checkSize(k));
    int m = this.tiempoSistema.get(12);
    String str5 = new String(checkSize(m));
    int n = this.tiempoSistema.get(13);
    String str6 = new String(checkSize(n));
    localStringBuffer1.append(str1 + "-" + str2 + "-" + str3);
    localStringBuffer2.append(str4 + ":" + str5 + ":" + str6);
    localStringBuffer3.append(localStringBuffer1 + " " + localStringBuffer2);
    this.time = new String(localStringBuffer2);
    this.date = new String(localStringBuffer1);
    this.datetime = new String(localStringBuffer3);
    this.nombreGrafico = new String(localStringBuffer1.toString() + str4 + str5 + str6);
  }
  
  private String checkSize(int paramInt)
  {
    StringBuffer localStringBuffer = new StringBuffer(paramInt + "");
    if (localStringBuffer.length() == 1) {
      localStringBuffer.insert(0, "0");
    }
    return localStringBuffer.toString();
  }
}
