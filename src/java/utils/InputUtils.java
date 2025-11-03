package utils;

import exception.SystemException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

public class InputUtils {

    // is null
    private static boolean isNull(String input) {
        return input == null || input.trim().isEmpty();
    }

    // check range String
    private static String validateRangeString(String input, String fieldName, int maxLength) throws SystemException {
        if (input.trim().length() > maxLength) {
            throw new SystemException(String.format("%s must not exceed %d characters.", fieldName, maxLength));
        }
        return input;
    }

    // check require String
    public static String validateRequiredString(String input, String fieldName, int maxLength) throws SystemException {

        // check empty string
        if (isNull(input)) {
            throw new SystemException(String.format("%s cannot be empty.", fieldName));
        }

        // check range string
        input = validateRangeString(input, fieldName, maxLength);
        return input.trim();
    }

    // check String (allow null)
    public static String validateOptionalString(String input, String fieldName, int maxLength) throws SystemException {

        // check null
        if (isNull(input)) {
            return null;
        }

        // check range
        input = validateRangeString(input, fieldName, maxLength);
        return input.trim();
    }

    // check valid int
    private static int validateInt(String input, String fieldName) throws SystemException {
        try {
            int n = Integer.parseInt(input.trim());
            return n;
        } catch (NumberFormatException e) {
            throw new SystemException(String.format("%s must be a valid integer.", fieldName));
        }
    }

    // check require int
    public static int validateRequiredInt(String input, String fieldName) throws SystemException {

        // check null
        if (isNull(input)) {
            throw new SystemException(String.format("%s cannot be empty.", fieldName));
        }

        // check valid int
        int n = validateInt(input, fieldName);
        return n;
    }

    // check int (allow nnull)
    public static Integer validateOptionalInt(String input, String fieldName) throws SystemException {

        // check null
        if (isNull(input)) {
            return null;
        }

        // check valid int (if not null)
        int n = validateInt(input, fieldName);
        return n;
    }

    // check date (allow null)
    public static LocalDate validateOptionalDate(String input, String fieldName) throws SystemException {

        // check null
        if (isNull(input)) {
            return null;
        }

        // check format date
        try {
            DateTimeFormatter formattter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            LocalDate date = LocalDate.parse(input.trim(), formattter);
            return date;
        } catch (DateTimeParseException e) {
            throw new SystemException(String.format("%s is invalid. Please use the format dd/MM/yyyy.", fieldName));

        }
    }
}
