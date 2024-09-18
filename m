Return-Path: <linux-block+bounces-11755-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAC397BDDB
	for <lists+linux-block@lfdr.de>; Wed, 18 Sep 2024 16:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383D01C20809
	for <lists+linux-block@lfdr.de>; Wed, 18 Sep 2024 14:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7294317C8B;
	Wed, 18 Sep 2024 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.kernel.org;
	s=subspace; t=1726668995;
	bh=R/YTf0ryj999vPTEkj3UhwIwteprL9up90M3nOHjFi8=;
	h=Subject:From:To:Date:List-Id:List-Subscribe:List-Unsubscribe:
	 From;
	b=fFLc03DLgJAKc/DlvHmQjlG/gK+8VVG51naKxixXV5ttHT0QphWOHeNx56zybHIlJ
	 sMCtQdYL8W1bAAUpW3KJ9PUSH+43WESOvLeQ3LstUSKpqX944ZxvbYoslvxUeUp9Ut
	 ON3wrIFWZ33CgVVPvPdm/ZeTY9OrCkYewbX1HZMw=
X-Original-To: linux-block@vger.kernel.org
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5AB17999
	for <linux-block@vger.kernel.org>; Wed, 18 Sep 2024 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.kernel.org;
	s=subspace; t=1726668995;
	bh=R/YTf0ryj999vPTEkj3UhwIwteprL9up90M3nOHjFi8=;
	h=Subject:From:To:Date:From;
	b=CUUYDqEUyEw3QI5iZswE0g3EwNsdjJQ1i0nejKrxYFiNvocXt020JLLKZ1/Q8Gxai
	 Dmpyzh/0yBtWDaIpURU7VF6lZqiruEfQ/yRZP2WvEwRWpMkPJKRagcc4lVDMMDdGmJ
	 YzFf98rHOSJionMze00sei1H+x+pQqpt7gjBWo2U=
Subject: =?utf-8?q?Welcome_to_maintainers=40linux.kernel.org?=
From: maintainers+help@linux.kernel.org
To: linux-block@vger.kernel.org
Message-ID: <1726668995-1384-mlmmj-02457641@linux.kernel.org>
Date: Wed, 18 Sep 2024 14:16:35 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Greetings!

This is the mlmmj program managing the <maintainers@linux.kernel.org>
mailing list.

This message describes the list's purpose and expectations:

- this list contains everyone who is listed as an M: entry in MAINTAINERS
- the subscriber data is automatically updated every time there is a change to
  the MAINTAINERS file, so this list should be continuously current
- this list is:

    - pre-moderated
    - unlisted
    - not archived

The purpose of this list is to be able to reach all current maintainers,
should there be a need to communicate something of importance to the entire
kernel maintainer community. It is expected to be extremely low volume.

You can unsubscribe at any time -- your subscription is not forced.

An administrator has subscribed you to the normal version of the list.

The email address you are subscribed with is <linux-block@vger.kernel.org>.

If you ever wish to unsubscribe, send a message to
<maintainers+unsubscribe@linux.kernel.org> using this email address. The
subject and the body of the message can be anything. You will then receive
confirmation or further instructions.

For other information and help about this list, send a message to
<maintainers+help@linux.kernel.org>.



