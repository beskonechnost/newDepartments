package ua.aimprosoft.korotkov.project.entity.extra;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;

/**
 * Created by Андрей on 16.11.2017.
 */
public class DateCheckAndParse {

    private Date date;
    private boolean flagError;
    private String textError;

    public DateCheckAndParse(Date date, boolean flagError, String textError) {
        this.date = date;
        this.flagError = flagError;
        this.textError = textError;
    }

    public Date getDate() {
        return date;
    }
    public void setDate(Date date) {
        this.date = date;
    }

    public boolean isFlagError() {
        return flagError;
    }
    public void setFlagError(boolean flagError) {
        this.flagError = flagError;
    }

    public String getTextError() {
        return textError;
    }
    public void setTextError(String textError) {
        this.textError = textError;
    }

    @Override
    public String toString() {
        return "DateCheckAndParse{" +
                "date=" + date +
                ", flagError=" + flagError +
                ", textError='" + textError + '\'' +
                '}';
    }

    public static DateCheckAndParse checkAndConvertDate(String birthdayDate) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        boolean flag = false;
        String text = null;
        java.sql.Date date = null;
        java.util.Date birthday = null;
        if(birthdayDate!=null) {
            try {
                birthday = format.parse(birthdayDate);
                Calendar cal = Calendar.getInstance();
                cal.setTime(birthday);

                date = new java.sql.Date(cal.getTimeInMillis());

                GregorianCalendar birthDay = new GregorianCalendar(cal.get(cal.YEAR), cal.get(cal.MONTH), cal.get(cal.DAY_OF_MONTH));
                GregorianCalendar now = new GregorianCalendar();
                int years = now.get(GregorianCalendar.YEAR) - birthDay.get(GregorianCalendar.YEAR);

                if (years < 14 || years > 60) {
                    flag = true;
                    text = "Age must be more than 14 and less than 60 years!";
                }
            } catch (ParseException e) {
                flag = true;
                text = "Error parse date";
            }
        }else{
            flag = true;
            text = "No date set";
        }
        return new DateCheckAndParse(date, flag, text);
    }
}
