<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Painel de Senhas</title>
</head>
<link rel="stylesheet" href="../css/stylePainel.css">
<body>
	<div class="container">

		<div class="content ">

			<div id="senha">
				<div
					style="margin: 0 auto; max-width: 300px; min-width: 200px; background-color: #fff; border-radius: 10px;">
					<p id="texto">0</p>
					
				</div>
				<div id="audio"></div>

			</div>
		</div>
	</div>
	<script src="../js/jquery.js"></script>
	<script type="text/javascript">
		
	</script>
	<script type="text/javascript">
		var webSocket = new WebSocket(
				"ws://localhost:8060/GeraUnity/ChamaSenha")

		webSocket.onmessage = function(event) {
			var messages = document.getElementById("texto");
			messages.innerHTML = event.data;
		//	document.getElementById('audio').innerHTML = '<audio src="alerta.wav" autoplay></audio>';
		//O comando acima é caso eu queira que saia audio ao receber a nova senha	
		
		//Fade in e fade ou para poder piscar o texto
		$('#texto').fadeOut(300).fadeIn(300).fadeOut(300).fadeIn(300)
					.fadeOut(300).fadeIn(300).fadeOut(300).fadeIn(300).fadeOut(
							300).fadeIn(300);
			
			var fala = new SpeechSynthesisUtterance();
			fala.text = 'Senha ' + event.data +' Comparecer ao Guichê de atendimento.' ;

			speechSynthesis.speak(fala);
		}

		
		
		



		window.onbeforeunload = function() {
			webSocket.close();
		};
	</script>
</body>
</html>