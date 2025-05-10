const formulario = document.getElementById('formulario');
const inputs = document.querySelectorAll('#formulario input');

const expresiones = {
   nombre: /^[a-zA-ZÀ-ÿ]{4,70}$/, // Letras.
   documento: /^\d{6,10}$/, // 6 a 10 digitos.
}

const campos = {
   nombre: false,
   documento: false
}

const validarformulario = (e) => {
   switch (e.target.name) {
      case "nombre":
         validarcampo(expresiones.nombre, e.target, 'nombre');
         break;
      case "documento":
         validarcampo(expresiones.documento, e.target, 'documento');
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
//=== funcio para redirigir al dashboard_guardia desde la flecha de retroceso !
function goBack() {
   window.location.href = "/frontend/views/dashboard_guardia.html";
}
