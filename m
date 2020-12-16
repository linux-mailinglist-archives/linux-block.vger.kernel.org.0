Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B662DC601
	for <lists+linux-block@lfdr.de>; Wed, 16 Dec 2020 19:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbgLPSPQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Dec 2020 13:15:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729802AbgLPSPQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Dec 2020 13:15:16 -0500
Date:   Thu, 17 Dec 2020 02:53:11 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608141198;
        bh=beZ5zvgm3d5FYRbXyTriclz2nvDJTTxcL1ZTuOmT20I=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=O8P7X2x0eAlzehcyaTwmWmatE0Itfm3bR91mpg65ceMW94S9B7KRb+z2KUiJU1TgK
         0OdoFm2JSjTFHQTco8lCEOsQj6jbPGgfRdDFFeXGDJ1rY9uacfyXoniAgnmg9UV0+A
         5/YrSlS/+Ou2b5LQFKPqhZkmL1osKdcz6KOhUEQg8+u1RFTtm2COX/BIrfxm8R938h
         eT1gTs+7jLf0U99QET+Zn9zn1Xgv+68OV23PjhMz1wIbynaZuJQMG/lAIxRXfBFU5l
         puzpLquA5ILxDb5/DeASTy3Ql0sGLKkNrxCCx2dPQg+dF3l4397fB60Co5ip/ywF+N
         Lqn1XbsXOZQNg==
From:   Keith Busch <kbusch@kernel.org>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, minwoo.im.dev@gmail.com
Subject: Re: nvme: enable char device per namespace
Message-ID: <20201216175311.GA31311@redsun51.ssa.fujisawa.hgst.com>
References: <20201215224607.GB3915989@dhcp-10-100-145-180.wdc.com>
 <10318EDE-F4D0-4C89-B69D-3D5ACA4308C2@javigon.com>
 <20201216162631.GA77639@dhcp-10-100-145-180.wdc.com>
 <20201216174322.v2ahfdhvgix536gd@unifi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201216174322.v2ahfdhvgix536gd@unifi>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 16, 2020 at 06:43:22PM +0100, Javier González wrote:
> Thanks Keith. I will send a new version today.
> 
> Regarding nvme-cli: what are your thoughts?

I was thinking we could add a column for these with the '--verbose'
option in the namespace section.
