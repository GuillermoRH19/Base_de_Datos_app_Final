/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package edu.mx.uttt.bda.control;
import java.util.List;
import edu.mx.uttt.bda.entidad.cliente;
import edu.mx.uttt.bda.model.ModelCliente;

/**
 *
 * @author Usuario
 */
public interface IOperaciones {
    void agregar(Object obj);
    boolean actualizar(Object obj);
    boolean editar(Object obj);
    List<Object> consultar();
}
