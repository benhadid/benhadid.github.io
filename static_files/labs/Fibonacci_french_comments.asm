# Calcule les douze premiers nombre de Fibonacci et les sauvegarde dans un tableau, ensuite les affiche 
        .data
fibs:   .word 0 : 12            # tableau de 12 mots pour contenir les valeurs de Fibonnaci
size:   .word 12                # taille du tableau
        .text
        la	$t0, fibs	# chargement de l'adresse du tableau
        la	$t5, size	# chargement de l'adresse de la variable 'size'
        lw	$t5, 0($t5)	# chargement de la taille du tableau
        li	$t2, 1  	# 1 est la première et seconde valeurs de Fibonacci        
        sw	$t2, 0($t0)	# fibs[0] = 1
        sw	$t2, 4($t0) 	# fibs[1] = fibs[0] = 1
        addi    $t1, $t5, -2    # Compteur de boucle. Pour boucler (size - 2 ) fois
loop:   lw	$t3, 0($t0) 	# lire la valeur de fibs[n]
        lw	$t4, 4($t0)	# lire la valeur de fibs[n+1]
        add	$t2, $t3, $t4	# $t2 = fibs[n] + fibs[n+1]
        sw	$t2, 8($t0)	# sauvegarder $t2 dans fibs[n+2]
        addi	$t0, $t0, 4	# incrémenter le pointeur sur fibs
        addi    $t1, $t1, -1    # décrementer le compteur de la boucle
        bgtz    $t1, loop       # boucler si le compteur est ? 0
        la      $a0, fibs       # initialisation du premier argument pour affichage (adresse du tableau)
        add     $a1, $0, $t5    # initialisation du second argument pour affichage (nombre d'éléments)
        jal     print           # appel de la fonction d'affichage
        li      $v0, 10         # initialisation pour le syscall afin de terminer l'exécution du programme
        syscall                 # l'appel système pour terminer

### routine pour afficher sur une ligne les nombres dans un tableau ###
print:	add	$sp, $sp, -8	# allocation de l'espace sur la pile pour sauvegarder les valeurs de $s0 et $s1
	sw	$s0, 0($sp)	# sauvegade de la valeur de $s0 sur la pile
	sw	$s1, 4($sp)	# sauvegade de la valeur de $s1 sur la pile
	
	add	$s0, $a0, $0	# récuperer l'adresse du tableau dans $s0 
	add	$s1, $a1, $0	# récuperer le nombre d'éléments à afficher dans $s1
		
do:	bltz 	$s1, pend	# quitter s'il n'y a rien à afficher
	lw	$a0, 0($s0)	# charger comme arguement la valeur à afficher depuis le tableau
	addi	$v0, $0, 1	# initialisation pour le syscall afin d'afficher un entier
	syscall			# l'appel système pour afficher l'entier
	addi	$a0, $0, ' '	# charger comme arguement pour affichage le caractère _espace_
	addi	$v0, $0, 11	# initialisation pour le syscall afin d'afficher un expace
	syscall			# l'appel système pour afficher le caractère espace
	addi	$s0, $s0, 4	# incrémenter le pointeur pour la prochaine valeur
	addi	$s1, $s1, -1	# décrementer le compteur de la boucle
	j do			# boucler sur la prochaine valeur
	
pend:	addi	$a0, $0, '\n'	# charger comme arguement pour affichage le caractère _saut_de_ligne_
	addi	$v0, $0, 11	# initialisation pour le syscall afin d'afficher un saut de ligne
	syscall			# l'appel système pour afficher le caractère

	lw	$s0, 0($sp)	# restaurer la valeur de $s0 depuis la pile
	lw	$s1, 4($sp)	# restaurer la valeur de $s1 depuis la pile
	add	$sp, $sp, 8	# libérer l'espace sur la pile 
	jr	$ra		# retour à la fonction appelante
	