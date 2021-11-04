class Planta {
	
	const property altura
	const anio
	
	method tolerancia()
	method espacio()

	method daSemillasAlternativamente() 
	
	method fuerte() {
		return self.tolerancia() > 10
	}
	
	method daSemillas() {
		return self.fuerte() or self.daSemillasAlternativamente()
	}
	
	method esIdeal(parcela)

// Alternativa por sobreescritura (super)	
//	method daSemillas() {
//		return self.fuerte()
//	}	
}

class Menta inherits Planta {
	
	
	override method tolerancia() {
		return 6
	}
	
	override method espacio() {
		return altura * 3
	}
	
	override method daSemillasAlternativamente() {
		return altura > 0.4
	}
	
	override method esIdeal(parcela) {
		return parcela.superficie() > 6
	}
	
// Alternativa por sobreescritura (super)	
//	override method daSemillas() {
//		return super() or altura > 0.4
//	}
}

class Soja inherits Planta{
	
	override method tolerancia() {
		return if (altura < 0.5)                 { 6 }
				else if (altura.between(0.5, 1)) { 7 }
				else                             { 9 }
	}
	
	override method espacio() {
		return altura/2
	}

	override method daSemillasAlternativamente() {
		return anio > 2007 and altura > 1
	} 
	
	override method esIdeal(parcela) {
		return self.tolerancia() == parcela.horasSol()
	}
	
	
}

class Quinoa inherits Planta {
	const property tolerancia
	
	override method espacio() {
		return 0.5
	}
	
	override method daSemillasAlternativamente() {
		return anio < 2005
	}
	
	override method esIdeal(parcela) {
		return parcela.todasMasBajasQue(1.5)	
	}
	
}

class SojaTransgenica inherits Soja {
	
	override method daSemillas() {
		return false
	}
	
	override method esIdeal(parcela) {
		return parcela.cantidadMaxima() == 1	
	}
	
	
}

class Hierbabuena inherits Menta {
	
	override method espacio() {
		return super() * 2
	}
}

class Parcela {
	const ancho
	const largo
	const property horasSol
	const plantas = #{}
	
	method superficie() {
		return ancho * largo
	}
	
	method cantidadMaxima() {
		return (if (ancho > largo ) {
			self.superficie() / 5
		}
		else {
			self.superficie() / 3 + largo
		}).truncate(0)
	}
	
	method complicada() {
		return plantas.any({planta => planta.tolerancia() < horasSol })
	}
	
	method hayEspacio() {
		return plantas.size() < self.cantidadMaxima()
	}
	
	method toleraSol(planta) {
		return planta.tolerancia() < horasSol + 2
	}
	
	method validarPlantar(planta) {
		if( ! self.hayEspacio() ) {
			self.error("no hay espacio suficiente para plantar")
		} 
		if(	! self.toleraSol(planta) )	{
			self.error("recibe demasiado sol ")
		}
	}
	
	method plantar(planta) {
		self.validarPlantar(planta)
		plantas.add(planta)
	}
	
	method todasMasBajasQue(altura) {
		return plantas.all({planta => planta.altura() <= altura})
	}
}


