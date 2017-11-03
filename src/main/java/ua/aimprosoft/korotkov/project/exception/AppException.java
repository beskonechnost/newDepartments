package ua.aimprosoft.korotkov.project.exception;

public class AppException extends Exception{

    private static final long serialVersionUID = 6933179067944218992L;

    public AppException() {
        super();
    }

    public AppException(String message, Throwable cause) {
        super(message, cause);
    }

    public AppException(String message) {
        super(message);
    }

}
