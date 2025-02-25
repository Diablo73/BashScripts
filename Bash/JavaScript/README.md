# Auto Google Meet Droper

Apply this script in the console
```javascript
setInterval(() => {
	const threshold = 1;
	const currentParticipantCount = document.querySelector('[aria-label*="People"]')
									.parentElement.parentElement
									.childNodes[1].childNodes[0]
									.textContent - 0;
	console.log(currentParticipantCount);
	if (currentParticipantCount <= threshold) {
		location.reload();
	}
}, 5000);
```

# Job Apply Scripts

## Instahyre
Open a job window, and apply this script in the console
```javascript
setInterval(() => {
	console.log(document.querySelector(".company-name").textContent + " -> " + document.querySelector(".experience").textContent);
	document.querySelector(".apply").click();
}, 2000);
```
```javascript
document.querySelector("#job-skills-description").innerText.split("\n");
```