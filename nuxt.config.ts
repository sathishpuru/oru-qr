// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
    compatibilityDate: '2024-11-01',
    devtools: { enabled: true },

    modules: [
        '@nuxtjs/tailwindcss',
        '@nuxtjs/supabase'
    ],

    supabase: {
        redirect: false,
        redirectOptions: {
            login: '/login',
            callback: '/confirm',
            exclude: ['/', '/pricing', '/features', '/q/*']
        },
        url: process.env.SUPABASE_URL || 'https://example.supabase.co',
        key: process.env.SUPABASE_KEY || 'your-anon-key'
    },

    runtimeConfig: {
        // Private keys (only available server-side)
        supabaseServiceKey: process.env.SUPABASE_SERVICE_KEY,
        stripeSecretKey: process.env.STRIPE_SECRET_KEY,
        stripeWebhookSecret: process.env.STRIPE_WEBHOOK_SECRET,
        resendApiKey: process.env.RESEND_API_KEY,

        // Public keys (exposed to client)
        public: {
            supabaseUrl: process.env.SUPABASE_URL,
            supabaseKey: process.env.SUPABASE_KEY,
            stripePublishableKey: process.env.STRIPE_PUBLISHABLE_KEY,
            appUrl: process.env.APP_URL || 'http://localhost:3000'
        }
    },

    app: {
        head: {
            title: 'OruQR - Dynamic QR Code Management',
            meta: [
                { charset: 'utf-8' },
                { name: 'viewport', content: 'width=device-width, initial-scale=1' },
                {
                    name: 'description',
                    content: 'Create, manage, and track dynamic QR codes with powerful analytics'
                }
            ],
            link: [
                { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
            ]
        }
    },

    css: ['~/assets/css/main.css']
})
