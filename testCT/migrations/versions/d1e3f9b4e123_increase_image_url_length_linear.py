"""
Increase image_url length to 1000 (linear path from 624fdffbc687)

Revision ID: d1e3f9b4e123
Revises: 624fdffbc687
Create Date: 2025-10-21 19:10:00.000000
"""

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'd1e3f9b4e123'
down_revision = '624fdffbc687'
branch_labels = None
depends_on = None


def upgrade():
    # Aumentar longitud de image_url en tablas relevantes
    with op.batch_alter_table('question') as batch_op:
        batch_op.alter_column('image_url', type_=sa.String(length=1000))

    # Algunos esquemas podrían usar nombre de tabla 'quiz_cuatro' según metadata
    # Usamos batch_alter_table para compatibilidad
    with op.batch_alter_table('quiz_cuatro') as batch_op:
        batch_op.alter_column('image_url', type_=sa.String(length=1000), existing_nullable=True)


def downgrade():
    with op.batch_alter_table('question') as batch_op:
        batch_op.alter_column('image_url', type_=sa.String(length=200))

    with op.batch_alter_table('quiz_cuatro') as batch_op:
        batch_op.alter_column('image_url', type_=sa.String(length=200), existing_nullable=True)
