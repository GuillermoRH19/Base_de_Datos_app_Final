/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author Memo
 */
public class CONEXION {

    public static void conectar(String[] args) {
        String url = "jdbc:sqlserver://localhost:1433;databaseName=Northwind;encrypt=true;trustServerCertificate=true";

        //Credenciales de la base de datos
        String user = "sa";
        String password = "123456789";

        Connection con = null;

        try {
            con = DriverManager.getConnection(url, user, password);
            System.out.println("Conexion exitosa a la base de datos");
        } catch (Exception e) {
            System.out.println(e.getMessage());
            System.out.println("Error al conectar a la base de datos.");
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {
                    System.out.println("no se pudo cerrar la conexion");
                }

            } else {
                System.out.println("La conexion esta cerrada");
            }

        }
    }

}
