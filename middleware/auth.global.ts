export default defineNuxtRouteMiddleware(async (to) => {
    const user = useSupabaseUser()

    // Redirect to login if accessing dashboard without authentication
    if (!user.value && to.path.startsWith('/dashboard')) {
        return navigateTo('/login')
    }

    // Redirect to dashboard if already logged in and accessing auth pages
    if (user.value && (to.path === '/login' || to.path === '/register')) {
        return navigateTo('/dashboard')
    }
})
