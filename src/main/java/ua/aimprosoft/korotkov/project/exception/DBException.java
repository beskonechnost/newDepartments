package ua.aimprosoft.korotkov.project.exception;


public class DBException extends AppException{

    private static final long serialVersionUID = -682774689117690688L;

    public DBException() {
        super();
    }

    public DBException(String message, Throwable cause) {
        super(message, cause);
    }
}
