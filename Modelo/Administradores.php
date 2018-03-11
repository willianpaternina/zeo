<?php

/**
 * Esta clase modela la tabla administradores de la base de datos
 *
 * @package    Modelo
 * @author     Willian Paternina <willian.paternina@unisinu.edu.co>
 * @copyright  2017-2018 Proyecto de grado para optar el titulo de ingeniero de sistemas
 * @version    1.0
 */
class Administradores extends Roles {
    
     private $idAdministrador;
     private $codigo;
     private $Rol;
     private $tipoidentificacion;
     private $identificacion;
     private $nombre;
     private $apellido;
     private $apellidocasada;
     private $genero;
     private $fechanacimiento;
     private $tiposangre;
     private $telefono;
     private $celular;
     private $estadocivil;
     private $ocupacion;
     private $religion;
     private $pais;
     private $departamento;
     private $municipio;
     private $domicilio;
     private $email;
     private $clave;
     private $fecharegistro;
     
     public function __Administradores ($idRol, $rol, $detalle, $idAdministrador, $codigo, $Rol, $tipoidentificacion, $identificacion, $nombre, $apellido, $apellidocasada, $genero, $fechanacimiento, $tiposangre, $telefono, $celular, $estadocivil, $ocupacion, $religion, $pais, $departamento, $municipio, $domicilio, $email, $clave, $fecharegistro) {
        parent::__Roles($idRol, $rol, $detalle);
        $this->idAdministrador = $idAdministrador;
        $this->codigo = $codigo;
        $this->Rol = $Rol;
        $this->tipoidentificacion = $tipoidentificacion;
        $this->identificacion = $identificacion;
        $this->nombre = $nombre;
        $this->apellido = $apellido;
        $this->apellidocasada = $apellidocasada;
        $this->genero = $genero;
        $this->fechanacimiento = $fechanacimiento;
        $this->tiposangre = $tiposangre;
        $this->telefono = $telefono;
        $this->celular = $celular;
        $this->estadocivil = $estadocivil;
        $this->ocupacion = $ocupacion;
        $this->religion = $religion;
        $this->pais = $pais;
        $this->departamento = $departamento;
        $this->municipio = $municipio;
        $this->domicilio = $domicilio;
        $this->email = $email;
        $this->clave = $clave;
        $this->fecharegistro = $fecharegistro;
    }
     
     function getIdAdministrador() {
         return $this->idAdministrador;
     }

     function getCodigo() {
         return $this->codigo;
     }

     function getRol() {
         return $this->Rol;
     }

     function getTipoidentificacion() {
         return $this->tipoidentificacion;
     }

     function getIdentificacion() {
         return $this->identificacion;
     }

     function getNombre() {
         return $this->nombre;
     }

     function getApellido() {
         return $this->apellido;
     }

     function getApellidocasada() {
         return $this->apellidocasada;
     }

     function getGenero() {
         return $this->genero;
     }

     function getFechanacimiento() {
         return $this->fechanacimiento;
     }

     function getTiposangre() {
         return $this->tiposangre;
     }

     function getTelefono() {
         return $this->telefono;
     }

     function getCelular() {
         return $this->celular;
     }

     function getEstadocivil() {
         return $this->estadocivil;
     }

     function getOcupacion() {
         return $this->ocupacion;
     }

     function getReligion() {
         return $this->religion;
     }

     function getPais() {
         return $this->pais;
     }

     function getDepartamento() {
         return $this->departamento;
     }

     function getMunicipio() {
         return $this->municipio;
     }

     function getDomicilio() {
         return $this->domicilio;
     }

     function getEmail() {
         return $this->email;
     }

     function getClave() {
         return $this->clave;
     }

     function getFecharegistro() {
         return $this->fecharegistro;
     }

     function setIdAdministrador($idAdministrador) {
         $this->idAdministrador = $idAdministrador;
     }

     function setCodigo($codigo) {
         $this->codigo = $codigo;
     }

     function setRol($Rol) {
         $this->Rol = $Rol;
     }

     function setTipoidentificacion($tipoidentificacion) {
         $this->tipoidentificacion = $tipoidentificacion;
     }

     function setIdentificacion($identificacion) {
         $this->identificacion = $identificacion;
     }

     function setNombre($nombre) {
         $this->nombre = $nombre;
     }

     function setApellido($apellido) {
         $this->apellido = $apellido;
     }

     function setApellidocasada($apellidocasada) {
         $this->apellidocasada = $apellidocasada;
     }

     function setGenero($genero) {
         $this->genero = $genero;
     }

     function setFechanacimiento($fechanacimiento) {
         $this->fechanacimiento = $fechanacimiento;
     }

     function setTiposangre($tiposangre) {
         $this->tiposangre = $tiposangre;
     }

     function setTelefono($telefono) {
         $this->telefono = $telefono;
     }

     function setCelular($celular) {
         $this->celular = $celular;
     }

     function setEstadocivil($estadocivil) {
         $this->estadocivil = $estadocivil;
     }

     function setOcupacion($ocupacion) {
         $this->ocupacion = $ocupacion;
     }

     function setReligion($religion) {
         $this->religion = $religion;
     }

     function setPais($pais) {
         $this->pais = $pais;
     }

     function setDepartamento($departamento) {
         $this->departamento = $departamento;
     }

     function setMunicipio($municipio) {
         $this->municipio = $municipio;
     }

     function setDomicilio($domicilio) {
         $this->domicilio = $domicilio;
     }

     function setEmail($email) {
         $this->email = $email;
     }

     function setClave($clave) {
         $this->clave = $clave;
     }

     function setFecharegistro($fecharegistro) {
         $this->fecharegistro = $fecharegistro;
     }
}

?>