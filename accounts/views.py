from django.shortcuts import render
from django.http import JsonResponse
from django.contrib.auth.models import User
from django.contrib import auth
from django.contrib.auth import logout as do_logout
from django.views.decorators.csrf import csrf_exempt

# Create your views here. 
@csrf_exempt 
def createUser(request):
    nombre = request.POST['nombre']
    apellidos = request.POST['apellidos']
    username = request.POST['username']
    password = request.POST['password']
    tipo = request.POST['tipo']
    """print(nombre)
    print(apellidos)
    print(username)
    print(password)
    print(tipo)"""

    dataUser = User.objects.filter(username=username)
    if dataUser:
        return JsonResponse({'response':'Existe'})
    else:
        user = User.objects.create_user(username=username,password=password, first_name=nombre, last_name=apellidos)
        user.is_staff = True if tipo == '1' else False
        user.save()
        return JsonResponse({'response':'OK'})
@csrf_exempt 
def auntentificar(request):
    user = request.POST['user']
    password = request.POST['pass']
    validar = auth.authenticate(username=user, password=password)
    if validar is not None:
        #auth.login(request, user)
        dataUser = User.objects.filter(username=user)
        return JsonResponse({'response':'OK','dataUser': list(dataUser.values('first_name','last_name','is_staff'))})
    else:
        return JsonResponse({'response':'err'})

def logout(request):
    do_logout(request)
    return JsonResponse({'response':'Sesión cerrada'})

def getUsers(request):    
    dataUsers = User.objects.all()
    return JsonResponse({'dataUsers': list(dataUsers.values('id','first_name','last_name','username','is_staff'))})

@csrf_exempt 
def updateUser(request):
    campo = request.POST['campo']
    idUser = request.POST['idUser']
    valor = request.POST['valor']

    user = User.objects.get(id=idUser)
    if campo == 'nombre':        
        user.first_name = valor
        user.save()
        return JsonResponse({'response': 'OK'})
    elif campo == 'apellidos':
        user.last_name = valor
        user.save()
        return JsonResponse({'response': 'OK'})
    elif campo == 'usuario':        
        user.username = valor
        user.save()
        return JsonResponse({'response': 'OK'})
    elif campo == 'pass':        
        user.set_password(valor)
        user.save()
        return JsonResponse({'response': 'OK'})
    elif campo == 'Tipo':
        user.is_staff = True if valor == 1 else False
        user.is_staff = False if valor == 0 else True
        user.save()
        return JsonResponse({'response': 'OK'})