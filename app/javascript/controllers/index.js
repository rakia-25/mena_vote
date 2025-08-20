// Import and register all your controllers from the importmap under controllers/*

import { application } from "./application"

import NavbarController from "./navbar_controller"
application.register("navbar", NavbarController)

import VoteController from "./vote_controller"
application.register("vote", VoteController)

import PaymentController from "./payment_controller"
application.register("payment", PaymentController)

import ModalDataController from "./modalData_controller"
application.register("modalData", ModalDataController)

import ModalController from "./modal_controller"
application.register("modal", ModalController)

import ContactController from "./contact_controller"
application.register("contact", ContactController)

import ClipboardController from "./clipboard_controller"
application.register("clipboard", ClipboardController)

import AccordionController from "./accordion_controller"
application.register("accordion", AccordionController)

import DonateController from "./donate_controller"
application.register("donate", DonateController)

import CountdownController from "./countdown_controller"
application.register("countdown", CountdownController)
