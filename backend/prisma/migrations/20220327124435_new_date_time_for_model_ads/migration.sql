-- AlterTable
ALTER TABLE "ads" ALTER COLUMN "createdAt" DROP NOT NULL,
ALTER COLUMN "createdAt" DROP DEFAULT,
ALTER COLUMN "createdAt" SET DATA TYPE DATE,
ALTER COLUMN "updateAt" DROP NOT NULL,
ALTER COLUMN "updateAt" SET DATA TYPE DATE;
