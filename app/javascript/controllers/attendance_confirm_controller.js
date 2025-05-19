import { Controller } from "@hotwired/stimulus"
import { Modal }      from "bootstrap"

// Connects to data-controller="attendance-confirm"
export default class extends Controller {
  connect() {
    this.bsModal     = new Modal(this.element)
    this.form        = this.element.querySelector("#confirmAttendanceForm")
    this.actionInput = this.element.querySelector("#confirmActionType")
    this.dateInput   = this.element.querySelector("#confirmDate")
    this.inInput     = this.element.querySelector("#confirmClockIn")
    this.outInput    = this.element.querySelector("#confirmClockOut")

    this.element.addEventListener("show.bs.modal", this.prepare.bind(this))
  }

  prepare(event) {
    const trigger = event.relatedTarget
    const action  = trigger.dataset.actionType
    const now     = new Date().toISOString()

    this.actionInput.value = action
    this.dateInput.value   = now.split("T")[0]
    if (action === "in") {
      this.inInput.value  = now
      this.outInput.value = ""
      this.showMessage("本当に【出勤】打刻しますか？")
    } else {
      this.outInput.value = now
      this.inInput.value  = ""
      this.showMessage("本当に【退勤】打刻しますか？")
    }
  }

  showMessage(text) {
    this.element.querySelector("#confirmMessage").textContent = text
  }

  confirm() {
    this.bsModal.hide()
    this.form.submit()
  }
}