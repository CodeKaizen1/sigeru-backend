<?php
class Ruta
{
    private $idRuta;
    private $zonaRuta;
    private $recorridoRuta;
    private $frecuenciaDeRecoleccionRuta;
    private $horarioRuta;
    private $estadoRuta;
    private $horaInicioRealRuta;
    private $horaFinRealRuta;
    private $estadoAdminRuta;
    // nombreRuta (agregado 09/10/2026): etiqueta corta para identificar una
    // ruta puntual cuando su barrio tiene mas de una (ej. "Pocitos 3") --
    // opcional, al final, mismo patron que el resto de las columnas que se
    // fueron agregando con ALTER TABLE (ver 01_code.sql, seccion 11).
    private $nombreRuta;
    // municipioRuta (agregado 14/10/2026, seccion 12): se completa solo al
    // elegir el barrio en "Nueva ruta" (se saca del municipioContenedor de
    // los contenedores de ese barrio), no es texto libre que tipee el admin.
    private $municipioRuta;

    // estadoRuta/horaInicioRealRuta/horaFinRealRuta: seguimiento del recorrido del día.
    // estadoAdminRuta: alta/baja administrativa de la ruta.
    public function __construct($idRuta, $zonaRuta, $recorridoRuta, $frecuenciaDeRecoleccionRuta, $horarioRuta, $estadoRuta = null, $horaInicioRealRuta = null, $horaFinRealRuta = null, $estadoAdminRuta = null, $nombreRuta = null, $municipioRuta = null)
    {
        $this->idRuta = $idRuta;
        $this->zonaRuta = $zonaRuta;
        $this->recorridoRuta = $recorridoRuta;
        $this->frecuenciaDeRecoleccionRuta = $frecuenciaDeRecoleccionRuta;
        $this->horarioRuta = $horarioRuta;
        $this->estadoRuta = $estadoRuta;
        $this->horaInicioRealRuta = $horaInicioRealRuta;
        $this->horaFinRealRuta = $horaFinRealRuta;
        $this->estadoAdminRuta = $estadoAdminRuta;
        $this->nombreRuta = $nombreRuta;
        $this->municipioRuta = $municipioRuta;
    }

    public function getIdRuta()
    {
        return $this->idRuta;
    }

    public function setIdRuta($idRuta)
    {
        $this->idRuta = $idRuta;
    }

    public function getZonaRuta()
    {
        return $this->zonaRuta;
    }

    public function setZonaRuta($zonaRuta)
    {
        $this->zonaRuta = $zonaRuta;
    }

    public function getRecorridoRuta()
    {
        return $this->recorridoRuta;
    }

    public function setRecorridoRuta($recorridoRuta)
    {
        $this->recorridoRuta = $recorridoRuta;
    }

    public function getFrecuenciaDeRecoleccionRuta()
    {
        return $this->frecuenciaDeRecoleccionRuta;
    }

    public function setFrecuenciaDeRecoleccionRuta($frecuenciaDeRecoleccionRuta)
    {
        $this->frecuenciaDeRecoleccionRuta = $frecuenciaDeRecoleccionRuta;
    }

    public function getHorarioRuta()
    {
        return $this->horarioRuta;
    }

    public function setHorarioRuta($horarioRuta)
    {
        $this->horarioRuta = $horarioRuta;
    }

    public function getEstadoRuta()
    {
        return $this->estadoRuta;
    }

    public function setEstadoRuta($estadoRuta)
    {
        $this->estadoRuta = $estadoRuta;
    }

    public function getHoraInicioRealRuta()
    {
        return $this->horaInicioRealRuta;
    }

    public function setHoraInicioRealRuta($horaInicioRealRuta)
    {
        $this->horaInicioRealRuta = $horaInicioRealRuta;
    }

    public function getHoraFinRealRuta()
    {
        return $this->horaFinRealRuta;
    }

    public function setHoraFinRealRuta($horaFinRealRuta)
    {
        $this->horaFinRealRuta = $horaFinRealRuta;
    }

    public function getEstadoAdminRuta()
    {
        return $this->estadoAdminRuta;
    }

    public function setEstadoAdminRuta($estadoAdminRuta)
    {
        $this->estadoAdminRuta = $estadoAdminRuta;
    }

    public function getNombreRuta()
    {
        return $this->nombreRuta;
    }

    public function setNombreRuta($nombreRuta)
    {
        $this->nombreRuta = $nombreRuta;
    }

    public function getMunicipioRuta()
    {
        return $this->municipioRuta;
    }

    public function setMunicipioRuta($municipioRuta)
    {
        $this->municipioRuta = $municipioRuta;
    }
}
?>
