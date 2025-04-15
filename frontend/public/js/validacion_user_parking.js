const formulario = document.getElementById('formulario');
const inputs = document.querySelectorAll('#formulario input');

const expresiones = {
   nombre: /^[a-zA-ZÀ-ÿ\s]{4,16}$/, // Letras, numeros, guion y guion_bajo
   apellido: /^[a-zA-ZÀ-ÿ\s]{4,16}$/, // Letras y espacios, pueden llevar acentos.
   documento: /^\d{6,10}$/, // 4 a 12 digitos.
   tarjeta: /^.{12}$/, // 4 a 12 digitos.
   correo: /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/,
   numero: /^\d{7,10}$/ // 7 a 10 numeros.
}

const campos = {
   nombre: false,
   apellido: false,
   tarjeta: false,
   correo: false,
   numero: false
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
      case "tarjeta":
         validarcampo(expresiones.tarjeta, e.target, 'tarjeta');
         break;
      case "correo":
         validarcampo(expresiones.correo, e.target, 'correo');
         break;
      case "numero":
         validarcampo(expresiones.numero, e.target, 'numero');
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