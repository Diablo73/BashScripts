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