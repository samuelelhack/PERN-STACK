import { Button, Card, CardContent, Grid2, TextField, Typography, MenuItem, Select, FormControl, InputLabel, CircularProgress } from "@mui/material"
import { useState, useEffect } from "react";
import { createRequestHandler } from "react-router-dom";
import { useNavigate } from "react-router-dom";

function CrearUsuario() {

  const [valores, setValores] = useState({
    nombre: '',
    correo: '',
    rol: '',
    clave: ''
  })

  const [cargando, setCargando] = useState(false)

  const navigate = useNavigate()

  const handleSubmit = async (e) =>{
    e.preventDefault();

    setCargando(true)

    const respuesta = await fetch('http://localhost:4000/tareas', {
      method: 'POST',
      body: JSON.stringify(valores), // lo que hacemos es transformas los datos en un string 
      headers: {"Content-Type": "application/json"}, //esto se hace para que sepa que es un objeto json
    }) 
    const data = await respuesta.json();
    console.log(data);

    setCargando(false)
    navigate('/') //para redireccionar al home sin refrescar la pagina
    };

  const handleChange = (e) => 
    setValores({...valores, [e.target.name]: e.target.value});
  

  return (
    <Grid2 container direction="colum" alignItems='center' justifyContent='center'>
      <Grid2 container spacing={2}> {/**a propiedad container indica que este Grid es un contenedor que puede contener otros Grid como hijos.
        spacing={2} define el espacio entre los elementos hijos del contenedor. 
        En este caso, el espacio es de 2 (un valor relativo al tema de Material-UI, 
        que generalmente se traduce en 16px). */}
        <Grid2 mobile={12} tablet={6} desktop={4}>
        <Card sx={{mt: 5}} style={{
          backgroundColor: '#1e272e',
          padding: "1rem"
        }}>
          <Typography variant="5" textAlign="center" color="white">
            Crear un Usuario
          </Typography>

          <CardContent> {/** par acolocar elementos dentro de la tarjeta */}
            <form onSubmit={handleSubmit}>

              <TextField  
              variant='filled' 
              label="Nombre"
              
              sx={{
                display: "block",
                margin: '.5rem 0'
              }}

              name = 'nombre'
              onChange={handleChange}

              slotProps={{
                htmlInput: {
                  maxLength: 10, // Limita la entrada a 10 caracteres
                  style: { color: 'white' }, // Personaliza el estilo del input
                },
                inputLabel: {
                  style: { color: 'white' }, // Personaliza el estilo de la etiqueta
                },
              }}

              />{/**es un input etsos reciben algun valor un nombre, etc  */} 
              
              <TextField 
              variant="filled" 
              label='Correo'
              
              sx={{
                display: "block",
                margin: '.5rem 0'
              }}
              name = 'correo'
              onChange={handleChange}

              slotProps={{
                htmlInput: {
                  maxLength: 10, // Limita la entrada a 10 caracteres
                  style: { color: 'white' }, // Personaliza el estilo del input
                },
                inputLabel: {
                  style: { color: 'white' }, // Personaliza el estilo de la etiqueta
                },
              }}

              />

            <FormControl fullWidth variant="filled" sx={{ margin: '.5rem 0' }}>
              <InputLabel id="rol-label" sx={{ color: 'white' }}>Rol</InputLabel>
              <Select
                labelId="rol-label"
                id="rol"
                name="rol"
                value={valores.rol}
                onChange={handleChange}
                sx={{
                  color: 'white', // Color del texto seleccionado
                  '& .MuiSelect-icon': { color: 'white' }, // Color del ícono del select
                }}
              >
                <MenuItem value="analista">Analista</MenuItem>
              </Select>
            </FormControl>

              <TextField  
              variant='filled' 
              label="Clave"
              
              //multiline
             //rows={4}

              sx={{
                display: "block",
                margin: '.5rem 0'
              }}

              name = 'clave'
              onChange={handleChange}

              slotProps={{
                htmlInput: {
                  //maxLength: 10, // Limita la entrada a 10 caracteres
                  style: { color: 'white' }, // Personaliza el estilo del input
                },
                inputLabel: {
                  style: { color: 'white' }, // Personaliza el estilo de la etiqueta
                },
              }}
              />

              <Button
              variant="contained" 
              color="primary" 
              type="submit"
              disabled={!valores.clave || !valores.nombre}
              >
                {cargando? <CircularProgress color='inherit' size={24}/> : 'Crear'}
              </Button>
            </form>
          </CardContent> 
        </Card>
        </Grid2>
      </Grid2>
    </Grid2>
  )
}

export default CrearUsuario