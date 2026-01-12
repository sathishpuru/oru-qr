<template>
  <div class="min-h-screen bg-gradient-to-br from-purple-50 via-white to-blue-50 flex items-center justify-center px-4">
    <div class="max-w-md w-full">
      <!-- Logo -->
      <div class="text-center mb-8">
        <div class="inline-flex items-center space-x-2 mb-4">
          <div class="w-12 h-12 bg-gradient-to-br from-purple-600 to-blue-600 rounded-lg flex items-center justify-center">
            <span class="text-white font-bold text-2xl">O</span>
          </div>
          <span class="text-3xl font-bold bg-gradient-to-r from-purple-600 to-blue-600 bg-clip-text text-transparent">
            OruQR
          </span>
        </div>
        <h1 class="text-2xl font-bold text-gray-900">Create your account</h1>
        <p class="text-gray-600 mt-2">Start creating dynamic QR codes today</p>
      </div>

      <!-- Register Form -->
      <div class="bg-white rounded-2xl shadow-xl p-8">
        <form @submit.prevent="handleRegister" class="space-y-6">
          <div>
            <label for="fullName" class="block text-sm font-medium text-gray-700 mb-2">
              Full name
            </label>
            <input
              id="fullName"
              v-model="fullName"
              type="text"
              required
              class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-600 focus:border-transparent transition"
              placeholder="John Doe"
            />
          </div>

          <div>
            <label for="email" class="block text-sm font-medium text-gray-700 mb-2">
              Email address
            </label>
            <input
              id="email"
              v-model="email"
              type="email"
              required
              class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-600 focus:border-transparent transition"
              placeholder="you@example.com"
            />
          </div>

          <div>
            <label for="password" class="block text-sm font-medium text-gray-700 mb-2">
              Password
            </label>
            <input
              id="password"
              v-model="password"
              type="password"
              required
              minlength="8"
              class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-600 focus:border-transparent transition"
              placeholder="••••••••"
            />
            <p class="mt-1 text-xs text-gray-500">Must be at least 8 characters</p>
          </div>

          <div class="flex items-start">
            <input
              id="terms"
              v-model="acceptTerms"
              type="checkbox"
              required
              class="mt-1 rounded border-gray-300 text-purple-600 focus:ring-purple-600"
            />
            <label for="terms" class="ml-2 text-sm text-gray-600">
              I agree to the <a href="#" class="text-purple-600 hover:text-purple-700">Terms of Service</a> and <a href="#" class="text-purple-600 hover:text-purple-700">Privacy Policy</a>
            </label>
          </div>

          <div v-if="error" class="p-3 bg-red-50 border border-red-200 rounded-lg">
            <p class="text-sm text-red-600">{{ error }}</p>
          </div>

          <div v-if="success" class="p-3 bg-green-50 border border-green-200 rounded-lg">
            <p class="text-sm text-green-600">{{ success }}</p>
          </div>

          <button
            type="submit"
            :disabled="loading"
            class="w-full px-6 py-3 bg-gradient-to-r from-purple-600 to-blue-600 text-white rounded-lg font-semibold hover:shadow-lg transition transform hover:scale-105 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {{ loading ? 'Creating account...' : 'Create account' }}
          </button>
        </form>

        <div class="mt-6 text-center">
          <p class="text-sm text-gray-600">
            Already have an account?
            <NuxtLink to="/login" class="text-purple-600 hover:text-purple-700 font-semibold">
              Sign in
            </NuxtLink>
          </p>
        </div>
      </div>

      <div class="mt-6 text-center">
        <NuxtLink to="/" class="text-sm text-gray-600 hover:text-gray-900">
          ← Back to home
        </NuxtLink>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
const supabase = useSupabaseClient()
const fullName = ref('')
const email = ref('')
const password = ref('')
const acceptTerms = ref(false)
const loading = ref(false)
const error = ref('')
const success = ref('')

const handleRegister = async () => {
  try {
    loading.value = true
    error.value = ''
    success.value = ''

    // Sign up with Supabase
    const { data, error: signUpError } = await supabase.auth.signUp({
      email: email.value,
      password: password.value,
      options: {
        data: {
          full_name: fullName.value
        }
      }
    })

    if (signUpError) throw signUpError

    if (data.user) {
      success.value = 'Account created! Please check your email to verify your account.'
      
      // Clear form
      fullName.value = ''
      email.value = ''
      password.value = ''
      acceptTerms.value = false

      // Redirect to login after 3 seconds
      setTimeout(() => {
        navigateTo('/login')
      }, 3000)
    }
  } catch (e: any) {
    error.value = e.message || 'An error occurred during registration'
  } finally {
    loading.value = false
  }
}

useHead({
  title: 'Sign Up - OruQR'
})
</script>
