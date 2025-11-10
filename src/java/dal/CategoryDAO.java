/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import model.Category;

/**
 *
 * @author FPT
 */
public class CategoryDAO extends DBContext {

    public List<Category> getAllCategoriesWithJobCount() {
        List<Category> categoryList = new ArrayList<>();
        String sql = """
            SELECT c.Id, c.Name, COUNT(j.id) AS jobCount
                        FROM Categories c
                        LEFT JOIN Jobs j ON c.Id = j.CategoryId
                        GROUP BY c.Id, c.Name
                        ORDER BY c.Name;
        """;

        if (connection == null) {
            System.out.println("Database connection is null! Check DBContext or properties file.");
            return null;
        }

        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {

            while (rs.next()) {
                Category category = new Category();
                category.setId((UUID) rs.getObject("Id"));
                category.setName(rs.getString("Name"));
                category.setJobCount(rs.getInt("jobCount"));
                categoryList.add(category);
            }

        } catch (SQLException ex) {
            System.out.println("SQL Error in getAllCategoriesWithJobCount: " + ex.getMessage());
            ex.printStackTrace();
        } catch (Exception ex) {
            System.out.println("Unexpected Error: " + ex.getMessage());
            ex.printStackTrace();
        }

        return categoryList;
    }
}
