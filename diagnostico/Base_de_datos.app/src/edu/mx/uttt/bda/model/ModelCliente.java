/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.mx.uttt.bda.model;

import edu.mx.uttt.bda.entidad.cliente;

/**
 *
 * @author Usuario
 */
public class ModelCliente {

    public boolean agregar(cliente cli) {
        String Resultado = "clave del cliente: " + cli.getCustomerId()
                + "Nombre del cliente: " + cli.getCompanyName()
                + "Contacto del cliente: " + (cli.getContacto().equals(" ") ? "NULL" : cli.getContacto())
                + "Contacto del cliente: " + (cli.getContacTitulo().equals(" ") ? "NULL" : cli.getContacTitulo());

        return true;
    }

}
