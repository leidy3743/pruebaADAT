"""
Increase image_url length to 1000 for Question and QuizCuatro

Revision ID: cc7e1c2a0c2f
Revises: beae1797a1b1
Create Date: 2025-10-21 18:40:00.000000
"""
from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic.
revision = 'cc7e1c2a0c2f'
down_revision = 'beae1797a1b1'
branch_labels = None
depends_on = None

def upgrade():
    # SQLite supports altering column type in Alembic by batch operations
    with op.batch_alter_table('question') as batch_op:
        batch_op.alter_column('image_url', type_=sa.String(length=1000))
    with op.batch_alter_table('quiz_cuatro') as batch_op:
        batch_op.alter_column('image_url', type_=sa.String(length=1000), existing_nullable=True)


def downgrade():
    with op.batch_alter_table('question') as batch_op:
        batch_op.alter_column('image_url', type_=sa.String(length=200))
    with op.batch_alter_table('quiz_cuatro') as batch_op:
        batch_op.alter_column('image_url', type_=sa.String(length=200), existing_nullable=True)
