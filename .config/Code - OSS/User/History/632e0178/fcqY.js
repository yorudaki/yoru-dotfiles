const form = document.querySelector("form");

form.addEventListener("submit", function(event) {
    event.preventDefault();

    const usuario = document.getElementById("usuario").value;
    const senha = document.getElementById("senha").value;

    const usuarioCorreto = "admin";
    const senhaCorreta = "1234";

    if (usuario === usuarioCorreto && senha === senhaCorreta) {
        alert("Login realizado com sucesso!");

        window.location.href = "/src/html/pagina-inicial.html";
    } 
    else {
        alert("Usuário ou senha incorretos!");
    }
});
