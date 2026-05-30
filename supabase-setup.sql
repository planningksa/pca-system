-- ============================================================
-- PCA SYSTEM - Supabase Database Setup
-- Ejecuta esto en: Supabase Dashboard → SQL Editor
-- ============================================================

-- Crear tabla para almacenar datos de cada sistema
CREATE TABLE IF NOT EXISTS systems (
  key TEXT PRIMARY KEY,
  recs JSONB DEFAULT '[]'::jsonb,
  locs JSONB DEFAULT '[]'::jsonb,
  refs JSONB DEFAULT '[]'::jsonb,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Activar Row Level Security
ALTER TABLE systems ENABLE ROW LEVEL SECURITY;

-- Permitir acceso a usuarios autenticados
CREATE POLICY "authenticated_all" ON systems
  FOR ALL
  USING (auth.role() = 'authenticated');

-- Opcional: Desactivar confirmación de email
-- Ve a: Authentication → Settings → General
-- Desactiva: "Confirm email" (para login sin verificación de email)
