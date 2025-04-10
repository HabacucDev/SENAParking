const formulario = document.getElementById('formulario');
const inputs = document.querySelectorAll('#formulario input');

const expresiones = {
   nombre: /^[a-zA-ZÀ-ÿ\s]{4,16}$/, // Letras y espacios, pueden llevar acentos.
   apellido: /^[a-zA-ZÀ-ÿ\s]{4,16}$/, // Letras y espacios, pueden llevar acentos.
   documento: /^\d{6,10}$/, // 6 a 10 digitos.
   correo: /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/,
   numero: /^\d{7,10}$/, // 7 a 14 numeros.
   usuario: /^[a-zA-Z0-9\_\-]{4,16}$/, // Letras, numeros, guion y guion_bajo
   contrasena: /^.{4,12}$/ // 4 a 12 digitos.
}

const campos = {
   nombre: false,
   apellido: false,
   documento: false,
   correo: false,
   numero: false,
   usuario: false,
   contrasena: false
}

const validarformulario = (e) => {
   switch (e.target.name) {
      case "nombre":
         validarcampo(expresiones.nombre, e.target, 'nombre');
         break;
      case "apellido":
         validarcampo(expresiones.apellido, e.target, 'apellido');
         break;
      case "documento":
         validarcampo(expresiones.documento, e.target, 'documento');
         break;
      case "correo":
         validarcampo(expresiones.correo, e.target, 'correo');
         break;
      case "numero":
         validarcampo(expresiones.numero, e.target, 'numero');
         break;
      case "usuario":
         validarcampo(expresiones.usuario, e.target, 'usuario');
         break;
      case "contrasena":
         validarcampo(expresiones.contrasena, e.target, 'contrasena');
         break;
   }
}

const validarcampo = (expresiones, input, campo) => {
   if (expresiones.test(input.value)) {
      document.getElementById(`grupo__${campo}`).classList.remove('formulario__grupo-incorrecto');
      document.getElementById(`grupo__${campo}`).classList.add('formulario__grupo-correcto');
      document.querySelector(`#grupo__${campo} .formulario__input-error`).classList.remove('formulario__input-error-activo');
      campos[campo] = true;
   } else {
      document.getElementById(`grupo__${campo}`).classList.add('formulario__grupo-incorrecto');
      document.getElementById(`grupo__${campo}`).classList.remove('formulario__grupo-correcto');
      document.querySelector(`#grupo__${campo} .formulario__input-error`).classList.add('formulario__input-error-activo');
      campos[campo] = false;
   }
}

inputs.forEach((input)=>{
   input.addEventListener('keyup', validarformulario);
   input.addEventListener('blur', validarformulario);
})

formulario.addEventListener('submit', (e)=>{
   e.preventDefault();
});