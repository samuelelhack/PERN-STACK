import { Drawer, Box, Button, Typography } from '@mui/material';
import { Link, useNavigate } from 'react-router-dom';

function Menu() {
  const navigate = useNavigate();

  return (
    <Box sx={{ display: 'flex' }}>
      {/* Barra lateral con Drawer */}
      <Drawer
        variant="permanent" // La barra lateral es permanente
        sx={{ /** a propiedad sx es una forma de aplicar estilos personalizados a los componentes de Material-UI.
          Es similar a style en HTML, pero con superpoderes adicionales, como acceso al tema de Material-UI y soporte para pseudoclases y selectores. */
          width: '250px', //ANCHO 
          flexShrink: 0, // Esta propiedad evita que el Drawer se encoja cuando el contenedor principal tiene un tamaño reducido.
          /*Es útil cuando el Drawer está dentro de un contenedor flexible (flexbox), ya que garantiza que mantenga su tamaño original. */
          '& .MuiDrawer-paper': { /*Aquí se están aplicando estilos específicos al papel (el contenido interno) del Drawer.
            & se refiere al componente actual (Drawer), y .MuiDrawer-paper es una clase interna de Material-UI que representa el contenido del Drawer. */
            width: '250px', //Asegura que el contenido interno del Drawer también tenga un ancho de 250 píxeles.
            //Esto es importante porque el Drawer puede tener un ancho diferente al de su contenido interno.
            boxSizing: 'border-box', /**Esta propiedad asegura que el ancho y el alto del Drawer incluyan el padding y el borde.
            Sin esto, el padding o el borde podrían aumentar el tamaño total del componente. */
            backgroundColor: '#1976d2',
            color: '#fff',
          },
        }}
      >
        <Box sx={{ padding: '16px' }} /* El componente Box es un contenedor flexible de Material-UI. La propiedad sx permite aplicar estilos personalizados.
        padding: '16px': Agrega un espacio interno de 16 píxeles alrededor del contenido del Box.*/> 
          <Typography variant="h6" sx={{ marginBottom: '16px' }}>
            <Link to="/" style={{ textDecoration: 'none', color: '#fff' }}>
              PERN STACK
            </Link>
          </Typography>
          <Button
            variant="contained"
            color='secondary'
            onClick={() => navigate('/usuarios/nuevo')}
            sx={{ marginTop: '16px' }}
          >
            Nuevo Usuario
          </Button>
        </Box>
      </Drawer>

      
    </Box>
  );
}

export default Menu;