from django.test import TestCase
from django.urls import reverse
from django.test import Client
from time import time


class PerformanceTestCase(TestCase):

    def setUp(self):
        self.client = Client()

    def test_index_performance(self):
        start_time = time()
        response = self.client.get(reverse('index'))
        end_time = time()
        duration = end_time - start_time
        self.assertTrue(duration < 0.5, f"A página demorou {duration} segundos para carregar.")
        # self.assertTrue(duration < 0.001, f"A página demorou {duration} segundos para carregar.")
