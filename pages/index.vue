<template>
  <div class="min-h-screen bg-gradient-to-br from-purple-50 via-white to-blue-50">
    <!-- Header -->
    <header class="container mx-auto px-4 py-6">
      <nav class="flex items-center justify-between">
        <div class="flex items-center space-x-2">
          <div class="w-10 h-10 bg-gradient-to-br from-purple-600 to-blue-600 rounded-lg flex items-center justify-center">
            <span class="text-white font-bold text-xl">O</span>
          </div>
          <span class="text-2xl font-bold bg-gradient-to-r from-purple-600 to-blue-600 bg-clip-text text-transparent">
            OruQR
          </span>
        </div>
        <div class="flex items-center space-x-4">
          <NuxtLink to="/features" class="text-gray-600 hover:text-gray-900 transition">
            Features
          </NuxtLink>
          <NuxtLink to="/pricing" class="text-gray-600 hover:text-gray-900 transition">
            Pricing
          </NuxtLink>
          <NuxtLink to="/login" class="text-gray-600 hover:text-gray-900 transition">
            Login
          </NuxtLink>
          <NuxtLink 
            to="/register" 
            class="px-6 py-2 bg-gradient-to-r from-purple-600 to-blue-600 text-white rounded-lg hover:shadow-lg transition"
          >
            Get Started
          </NuxtLink>
        </div>
      </nav>
    </header>

    <!-- Hero Section -->
    <main class="container mx-auto px-4 py-20">
      <div class="text-center max-w-4xl mx-auto">
        <h1 class="text-6xl font-bold mb-6 bg-gradient-to-r from-purple-600 via-blue-600 to-purple-600 bg-clip-text text-transparent">
          Dynamic QR Codes That Adapt With You
        </h1>
        <p class="text-xl text-gray-600 mb-8 max-w-2xl mx-auto">
          Create, manage, and track QR codes that you can update anytime. 
          Get powerful analytics and insights on every scan.
        </p>
        <div class="flex items-center justify-center space-x-4">
          <NuxtLink 
            to="/register" 
            class="px-8 py-4 bg-gradient-to-r from-purple-600 to-blue-600 text-white rounded-lg text-lg font-semibold hover:shadow-xl transition transform hover:scale-105"
          >
            Start Free Trial
          </NuxtLink>
          <NuxtLink 
            to="/features" 
            class="px-8 py-4 border-2 border-purple-600 text-purple-600 rounded-lg text-lg font-semibold hover:bg-purple-50 transition"
          >
            Learn More
          </NuxtLink>
        </div>
      </div>

      <!-- Features Grid -->
      <div class="mt-32 grid md:grid-cols-3 gap-8">
        <div class="bg-white p-8 rounded-2xl shadow-lg hover:shadow-xl transition">
          <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center mb-4">
            <svg class="w-6 h-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4" />
            </svg>
          </div>
          <h3 class="text-xl font-bold mb-2">Dynamic Updates</h3>
          <p class="text-gray-600">
            Change your QR code destination anytime without reprinting. Perfect for campaigns and evolving content.
          </p>
        </div>

        <div class="bg-white p-8 rounded-2xl shadow-lg hover:shadow-xl transition">
          <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center mb-4">
            <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
            </svg>
          </div>
          <h3 class="text-xl font-bold mb-2">Powerful Analytics</h3>
          <p class="text-gray-600">
            Track scans, locations, devices, and more. Get insights to optimize your marketing campaigns.
          </p>
        </div>

        <div class="bg-white p-8 rounded-2xl shadow-lg hover:shadow-xl transition">
          <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center mb-4">
            <svg class="w-6 h-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01" />
            </svg>
          </div>
          <h3 class="text-xl font-bold mb-2">Custom Design</h3>
          <p class="text-gray-600">
            Customize colors, add logos, and create branded QR codes that match your identity.
          </p>
        </div>
      </div>
    </main>

    <!-- Footer -->
    <footer class="container mx-auto px-4 py-8 mt-20 border-t border-gray-200">
      <div class="text-center text-gray-600">
        <p>&copy; 2026 OruQR. All rights reserved.</p>
      </div>
    </footer>
  </div>
</template>

<script setup lang="ts">
useHead({
  title: 'OruQR - Dynamic QR Code Management',
  meta: [
    { name: 'description', content: 'Create, manage, and track dynamic QR codes with powerful analytics' }
  ]
})
</script>
