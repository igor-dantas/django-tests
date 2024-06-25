from django.test import TestCase
from core.models import Servico, Funcionario, Cargo
from model_mommy import mommy


class DatabaseTestCase(TestCase):

    def test_servico_integridade(self):
        servico = mommy.make('Servico')
        self.assertIsInstance(servico, Servico)
        self.assertTrue(servico.ativo)
        self.assertIsNotNone(servico.criados)
        self.assertIsNotNone(servico.modificado)

    def test_funcionario_integridade(self):
        cargo = mommy.make('Cargo')
        funcionario = mommy.make('Funcionario', cargo=cargo)
        self.assertIsInstance(funcionario, Funcionario)
        self.assertEqual(funcionario.cargo, cargo)
        self.assertIsNotNone(funcionario.imagem)


# class DatabaseTestCase(TestCase):
#     def test_servico_integridade(self):
#         servico = mommy.make('Servico')
#         self.assertIsInstance(servico, Servico)
#         self.assertFalse(servico.ativo)
#
#     def test_funcionario_integridade(self):
#         cargo = mommy.make('Cargo')
#         funcionario = mommy.make('Funcionario', cargo=cargo)
#         self.assertIsInstance(funcionario, Funcionario)
#         self.assertNotEqual(funcionario.cargo, cargo)
#         self.assertIsNone(funcionario.imagem)
