addEventListener("direct-upload:initialize", event => {
  const { target, detail } = event
  const { id, file } = detail

  target.insertAdjacentHTML("beforebegin", `
    <div id="direct-upload-${id}" class="direct-upload direct-upload--pending">
      <div id="direct-upload-progress-${id}" class="direct-upload__progress" style="width: 0%"></div>
      <span class="direct-upload__filename">${file.name}</span>
    </div>
  `)
})
 
addEventListener("direct-upload:start", event => {
  console.log('upload started')
  const { id } = event.detail
  const element = document.getElementById(`direct-upload-${id}`)
  element.classList.remove("direct-upload--pending")
})
 
addEventListener("direct-upload:progress", event => {
  console.log('upload progress')
  const { id, progress } = event.detail
  const progressElement = document.getElementById(`direct-upload-progress-${id}`)
  progressElement.style.width = `${progress}%`
})
 
addEventListener("direct-upload:error", event => {
  console.log('upload error')
  event.preventDefault()
  const { id, error } = event.detail
  const element = document.getElementById(`direct-upload-${id}`)
  element.classList.add("direct-upload--error")
  element.setAttribute("title", error)
})
 
addEventListener("direct-upload:end", event => {
  console.log('upload end')
  const { id } = event.detail
  const element = document.getElementById(`direct-upload-${id}`)
  element.classList.add("direct-upload--complete")
})