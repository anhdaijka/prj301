package utils;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Map;

public class InputUtils {

    // is null
    private static boolean isNull(String input) {
        return input == null || input.trim().isEmpty();
    }

    // check range String
    private static String validateRangeString(String input, String fieldName, int maxLength, Map<String, String> errors) {
        if (input.trim().length() > maxLength) {
            errors.put(fieldName, String.format("%s must not exceed %d characters.", fieldName, maxLength));
            return null;
        }
        return input;
    }

    // check require String
    public static String validateRequiredString(String input, String fieldName, int maxLength, Map<String, String> errors) {

        // check empty string
        if (isNull(input)) {
            errors.put(fieldName, String.format("%s cannot be empty.", fieldName));
            return null;
        }

        // check range string
        input = validateRangeString(input, fieldName, maxLength, errors);

        // if range error
        if (isNull(input)) {
            return null;
        }
        return input.trim();
    }

    // check String (allow null)
    public static String validateOptionalString(String input, String fieldName, int maxLength, Map<String, String> errors) {

        // check null
        if (isNull(input)) {
            return null;
        }

        // check range
        input = validateRangeString(input, fieldName, maxLength, errors);
        return input;
    }

    // check valid int
    private static int validateInt(String input, String fieldName, Map<String, String> errors) {
        try {
            int n = Integer.parseInt(input.trim());
            return n;
        } catch (NumberFormatException e) {
            errors.put(fieldName, String.format("%s must be a valid integer.", fieldName));
            return 0;
        }
    }

    // check require int
    public static int validateRequiredInt(String input, String fieldName, Map<String, String> errors) {

        // check null
        if (isNull(input)) {
            errors.put(fieldName, String.format("%s cannot be empty.", fieldName));
            return 0;
        }

        // check valid int
        int n = validateInt(input, fieldName, errors);
        return n;
    }

    // check int (allow null)
    public static Integer validateOptionalInt(String input, String fieldName, Map<String, String> errors) {

        // check null
        if (isNull(input)) {
            return null;
        }

        // check valid int (if not null)
        Integer n = validateInt(input, fieldName, errors);
        return n;
    }

    // required select
    public static int validateRequiredSelect(String input, String fieldName, Map<String, String> errors) {

        // check null
        if (isNull(input)) {
            errors.put(fieldName, String.format("You must select a %s.", fieldName.toLowerCase()));
            return 0;
        }

        // check valid int 
        try {
            int n = Integer.parseInt(input.trim());
            return n;
        } catch (NumberFormatException e) {
            errors.put(fieldName, String.format("The selected %s is invalid.", fieldName));
            return 0;
        }
    }

    // check date (allow null)
    public static LocalDate validateOptionalDate(String input, String fieldName, Map<String, String> errors) {

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
            errors.put(fieldName, String.format("%s is invalid. Please use the format dd/MM/yyyy.", fieldName));
            return null;
        }
    }
}
